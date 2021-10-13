SET NOCOUNT ON;
IF OBJECT_ID('U_EMUTOMHTR2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMHTR2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMUTOMHTR2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMUTOMHTR2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMUTOMHTR2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMUTOMHTR2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMUTOMHTR2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMUTOMHTR2];
GO
IF OBJECT_ID('U_EMUTOMHTR2_File') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMHTR2_File];
GO
IF OBJECT_ID('U_EMUTOMHTR2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMHTR2_EEList];
GO
IF OBJECT_ID('U_EMUTOMHTR2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMHTR2_AuditFields];
GO
IF OBJECT_ID('U_EMUTOMHTR2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMHTR2_Audit];
GO
IF OBJECT_ID('U_dsi_EMUTOMHTR2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EMUTOMHTR2_drvTbl];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EMUTOMHTR2_Master') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EMUTOMHTR2_Master];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EMUTOMHTR2_Coverage') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EMUTOMHTR2_Coverage];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EMUTOMHTR2_BDM') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EMUTOMHTR2_BDM];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_EMUTOMHTR2') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_EMUTOMHTR2];
GO
IF OBJECT_ID('U_dsi_BDM_EMUTOMHTR2') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMUTOMHTR2];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMUTOMHTR2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMUTOMHTR2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMUTOMHTR2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMUTOMHTR2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMUTOMHTR2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EMUTOMHTR2','Mutual of Omaha Benefits Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMUTOMHTR2Z0','N','Jun 17 2015  3:10PM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMUTOMHTR2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransDate"','1','(''UD112''=''F'')','EMUTOMHTR2Z0','8','D','10','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupID"','2','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','3','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubscriberID"','4','(''UA''=''F'')','EMUTOMHTR2Z0','9','D','10','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','5','(''SS''=''F'')','EMUTOMHTR2Z0','1','D','10','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''F'')','EMUTOMHTR2Z0','35','D','10','28',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''F'')','EMUTOMHTR2Z0','15','D','10','63',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','8','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','78',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','9','(''SS''=''F'')','EMUTOMHTR2Z0','10','D','10','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','10','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','89',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','11','(''UD112''=''F'')','EMUTOMHTR2Z0','8','D','10','90',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','12','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','98',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpID"','13','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','99',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','14','(''UA''=''F'')','EMUTOMHTR2Z0','30','D','10','109',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','15','(''SS''=''F'')','EMUTOMHTR2Z0','10','D','10','139',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','16','(''UA''=''F'')','EMUTOMHTR2Z0','30','D','10','149',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','17','(''SS''=''F'')','EMUTOMHTR2Z0','10','D','10','179',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress3"','18','(''UA''=''F'')','EMUTOMHTR2Z0','40','D','10','189',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','19','(''UA''=''F'')','EMUTOMHTR2Z0','19','D','10','229',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','20','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','248',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIP"','21','(''UA''=''F'')','EMUTOMHTR2Z0','11','D','10','250',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','22','(''UA''=''F'')','EMUTOMHTR2Z0','4','D','10','261',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','23','(''UA''=''F'')','EMUTOMHTR2Z0','20','D','10','265',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','24','(''UA''=''F'')','EMUTOMHTR2Z0','20','D','10','285',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkExt"','25','(''UA''=''F'')','EMUTOMHTR2Z0','4','D','10','305',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','26','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','309',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate"','27','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','317',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberSSN"','28','(''UA''=''F'')','EMUTOMHTR2Z0','9','D','10','325',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','29','(''SS''=''F'')','EMUTOMHTR2Z0','1','D','10','334',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTimeStudent"','30','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','335',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','31','(''SS''=''F'')','EMUTOMHTR2Z0','50','D','10','343',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipDate"','32','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','393',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubgroupID"','33','(''UA''=''F'')','EMUTOMHTR2Z0','4','D','10','401',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDataSegDate"','34','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','405',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','35','(''SS''=''F'')','EMUTOMHTR2Z0','2','D','10','413',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','36','(''UA''=''F'')','EMUTOMHTR2Z0','20','D','10','415',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDept"','37','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','435',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocID"','38','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','443',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','39','(''SS''=''F'')','EMUTOMHTR2Z0','1','D','10','451',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocDesc"','40','(''UA''=''F'')','EMUTOMHTR2Z0','23','D','10','452',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalEffDate"','41','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','475',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalMode"','42','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','483',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalAmt"','43','(''UA''=''F'')','EMUTOMHTR2Z0','16','D','10','484',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','44','(''SS''=''F'')','EMUTOMHTR2Z0','8','D','10','500',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','45','(''SS''=''F'')','EMUTOMHTR2Z0','1','D','10','508',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','46','(''SS''=''F'')','EMUTOMHTR2Z0','2','D','10','509',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','47','(''SS''=''F'')','EMUTOMHTR2Z0','16','D','10','511',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','48','(''SS''=''F'')','EMUTOMHTR2Z0','8','D','10','527',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','49','(''SS''=''F'')','EMUTOMHTR2Z0','1','D','10','535',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','50','(''SS''=''F'')','EMUTOMHTR2Z0','2','D','10','536',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','51','(''SS''=''F'')','EMUTOMHTR2Z0','16','D','10','538',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','52','(''SS''=''F'')','EMUTOMHTR2Z0','8','D','10','554',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','53','(''SS''=''F'')','EMUTOMHTR2Z0','1','D','10','562',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','54','(''SS''=''F'')','EMUTOMHTR2Z0','2','D','10','563',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','55','(''SS''=''F'')','EMUTOMHTR2Z0','16','D','10','565',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','56','(''SS''=''F'')','EMUTOMHTR2Z0','8','D','10','581',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','57','(''SS''=''F'')','EMUTOMHTR2Z0','1','D','10','589',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','58','(''SS''=''F'')','EMUTOMHTR2Z0','2','D','10','590',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','59','(''SS''=''F'')','EMUTOMHTR2Z0','16','D','10','592',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassEffDate"','60','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','608',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassID"','61','(''UA''=''F'')','EMUTOMHTR2Z0','4','D','10','616',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRateEffDAte"','62','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','620',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSmoker"','63','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','628',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','64','(''SS''=''F'')','EMUTOMHTR2Z0','3','D','10','629',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalLateEntrant"','65','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','632',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','66','(''SS''=''F'')','EMUTOMHTR2Z0','122','D','10','633',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentProdCatD"','67','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','755',NULL,'Dental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentEffDateD"','68','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','756',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentEligEventD"','69','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','764',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentPlanIDD"','70','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','766',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentFamCovD"','71','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','776',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','72','(''SS''=''F'')','EMUTOMHTR2Z0','33','D','10','777',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCat1"','73','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','810',NULL,'Basic Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate1"','74','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','811',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEvent1"','75','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','819',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanID1"','76','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','821',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCov1"','77','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','831',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','78','(''SS''=''F'')','EMUTOMHTR2Z0','33','D','10','832',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCata"','79','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','865',NULL,'Basic AD&D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDatea"','80','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','866',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventa"','81','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','874',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDa"','82','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','876',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCova"','83','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','886',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','84','(''SS''=''F'')','EMUTOMHTR2Z0','33','D','10','887',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCatS"','85','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','920',NULL,'Basic STD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateS"','86','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','921',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventS"','87','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','929',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDS"','88','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','931',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCovS"','89','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','941',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','90','(''SS''=''F'')','EMUTOMHTR2Z0','33','D','10','942',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCatT"','91','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','975',NULL,'LTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateT"','92','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','976',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventT"','93','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','984',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDT"','94','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','986',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCovT"','95','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','996',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','96','(''SS''=''F'')','EMUTOMHTR2Z0','4','D','10','997',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDateT"','97','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1001',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmtT"','98','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1009',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','99','(''SS''=''F'')','EMUTOMHTR2Z0','11','D','10','1019',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCat3"','100','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1030',NULL,'Vol EE Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate3"','101','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1031',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEvent3"','102','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1039',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanID3"','103','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1041',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCov3"','104','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1051',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','105','(''SS''=''F'')','EMUTOMHTR2Z0','4','D','10','1052',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDate3"','106','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1056',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmt3"','107','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1064',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','108','(''SS''=''F'')','EMUTOMHTR2Z0','11','D','10','1074',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCat4"','109','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1085',NULL,'Vol ES Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate4"','110','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1086',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEvent4"','111','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1094',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanID4"','112','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1096',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCov4"','113','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1106',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','114','(''SS''=''F'')','EMUTOMHTR2Z0','4','D','10','1107',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDate4"','115','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1111',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmt4"','116','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1119',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','117','(''SS''=''F'')','EMUTOMHTR2Z0','11','D','10','1129',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCat5"','118','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1140',NULL,'Vol Dep Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate5"','119','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1141',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEvent5"','120','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1149',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanID5"','121','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1151',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCov5"','122','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1161',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','123','(''SS''=''F'')','EMUTOMHTR2Z0','4','D','10','1162',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDate5"','124','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1166',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmt5"','125','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1174',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','126','(''SS''=''F'')','EMUTOMHTR2Z0','11','D','10','1184',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCatc"','127','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1195',NULL,'Vol EE AD&D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDatec"','128','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1196',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventc"','129','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1204',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDc"','130','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1206',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCovc"','131','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1216',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','132','(''SS''=''F'')','EMUTOMHTR2Z0','4','D','10','1217',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDatec"','133','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1221',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmtc"','134','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1229',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','135','(''SS''=''F'')','EMUTOMHTR2Z0','11','D','10','1239',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCate"','136','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1250',NULL,'Vol ES AD&D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDatee"','137','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1251',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEvente"','138','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1259',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDe"','139','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1261',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCove"','140','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1271',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','141','(''SS''=''F'')','EMUTOMHTR2Z0','4','D','10','1272',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDatee"','142','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1276',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmte"','143','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1284',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','144','(''SS''=''F'')','EMUTOMHTR2Z0','11','D','10','1294',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCatd"','145','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1305',NULL,'Vol EC AD&D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDated"','146','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1306',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventd"','147','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1314',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDd"','148','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1316',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCovd"','149','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1326',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','150','(''SS''=''F'')','EMUTOMHTR2Z0','4','D','10','1327',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDated"','151','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1331',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmtd"','152','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1339',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','153','(''SS''=''F'')','EMUTOMHTR2Z0','11','D','10','1349',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCatQ"','154','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1360',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateQ"','155','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1361',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventQ"','156','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1369',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDQ"','157','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1371',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCovQ"','158','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1381',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','159','(''SS''=''F'')','EMUTOMHTR2Z0','4','D','10','1382',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','160','(''SS''=''F'')','EMUTOMHTR2Z0','8','D','10','1386',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','161','(''SS''=''F'')','EMUTOMHTR2Z0','10','D','10','1394',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','162','(''SS''=''F'')','EMUTOMHTR2Z0','10','D','10','1404',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorSTDCovL"','163','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1414',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCatR"','164','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1415','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateR"','165','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1416','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventR"','166','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1424','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDR"','167','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1426','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCovR"','168','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1436','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','169','(''SS''=''F'')','EMUTOMHTR2Z0','33','D','10','1437',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCatAA"','170','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1470','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateAA"','171','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1471','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventAA"','172','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1479','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDAA"','173','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1481','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCovAA"','174','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1491','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','175','(''SS''=''F'')','EMUTOMHTR2Z0','4','D','10','1492','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDateAA"','177','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1496','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmtAA"','178','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1504',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','179','(''SS''=''F'')','EMUTOMHTR2Z0','11','D','10','1514','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCatJ"','180','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1525','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateJ"','181','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1526','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventJ"','182','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1534','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDJ"','183','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1536','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCovJ"','184','(''UA''=''F'')','EMUTOMHTR2Z0','5','D','10','1546','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDateJ"','185','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1551','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmtJ"','186','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1559','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','187','(''SS''=''F'')','EMUTOMHTR2Z0','286','D','10','1569',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCatg"','188','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1855','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateg"','189','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1856','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligEventg"','190','(''UA''=''F'')','EMUTOMHTR2Z0','2','D','10','1864','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanIDg"','191','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1866','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamCovg"','192','(''UA''=''F'')','EMUTOMHTR2Z0','1','D','10','1876','',NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomEffDateg"','194','(''UA''=''F'')','EMUTOMHTR2Z0','8','D','10','1877',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNomAmtg"','195','(''UA''=''F'')','EMUTOMHTR2Z0','10','D','10','1885','',NULL,NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EMUTOMHTR2_20211012.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Open enrollment - active','201608159','EMPEXPORT','OEACTIVE','Sep 14 2021  5:49PM','EMUTOMHTR2',NULL,NULL,NULL,'201608159','Jul 12 2016  6:20PM','Dec 30 1899 12:00AM','201605011','0','','','201605011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Open enrollment - passive','201608159','EMPEXPORT','OEPASSIVE','Jul 12 2016  6:20PM','EMUTOMHTR2',NULL,NULL,NULL,'201608159','Jul 12 2016  6:20PM','Dec 30 1899 12:00AM','201605011',NULL,'','','201605011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','XPJBH',NULL,NULL,NULL,'MoO VolLife, Dis wkly Tues2pm','201905029','EMPEXPORT','SCHEDULED','Jul 12 2016  6:20PM','EMUTOMHTR2',NULL,NULL,NULL,'202110059','Jul 12 2016  6:20PM','Dec 30 1899 12:00AM','202109281',NULL,'','','201905021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test purposes only','202108261','EMPEXPORT','TEST','Sep 14 2021  5:52PM','EMUTOMHTR2',NULL,NULL,NULL,'202108261','Aug 26 2021 12:00AM','Dec 30 1899 12:00AM','202108121','1661','','','202108121',dbo.fn_GetTimedKey(),NULL,'us3rVaTRI1026',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','ExportDescription','C','Mutual of Omaha Benefits Export');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','InitialSort','C','drvMemberSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','MaxFileLength','C','1513');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','SystemID','V','AOE4OR0040K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMUTOMHTR2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EMUTOMHTR2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EMUTOMHTR2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EMUTOMHTR2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMUTOMHTR2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMUTOMHTR2','D10','dbo.U_Dsi_DrvTbl_EMUTOMHTR2',NULL);
IF OBJECT_ID('U_dsi_BDM_EMUTOMHTR2') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMUTOMHTR2] (
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
IF OBJECT_ID('U_Dsi_DrvTbl_EMUTOMHTR2') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EMUTOMHTR2] (
    [DrvCOID] char(5) NULL,
    [DrvEEID] char(12) NULL,
    [DrvDepID] varchar(30) NULL,
    [drvTransDate] char(8) NULL,
    [drvGroupID] varchar(8) NOT NULL,
    [drvRelationship] varchar(50) NULL,
    [drvSubscriberID] char(11) NULL,
    [drvNameLast] varchar(50) NULL,
    [drvNameFirst] varchar(50) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDateOfBirth] char(8) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvEmpID] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(50) NULL,
    [drvAddressLine2] varchar(50) NULL,
    [drvAddress3] varchar(1) NOT NULL,
    [drvAddressCity] varchar(60) NULL,
    [drvAddressState] varchar(50) NULL,
    [drvZIP] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkExt] varchar(1) NOT NULL,
    [drvDateOfHire] varchar(50) NULL,
    [drvEffDate] varchar(50) NULL,
    [drvMemberSSN] varchar(1) NOT NULL,
    [drvFullTimeStudent] varchar(1) NOT NULL,
    [drvRelationshipDate] varchar(50) NULL,
    [drvSubgroupID] varchar(50) NULL,
    [drvEmpDataSegDate] datetime NULL,
    [drvOccupation] varchar(1) NOT NULL,
    [drvDept] varchar(1) NOT NULL,
    [drvLocID] varchar(2) NOT NULL,
    [drvLocDesc] varchar(9) NOT NULL,
    [drvDateofLastHire] datetime NULL,
    [drvSalEffDate] char(8) NULL,
    [drvSalMode] varchar(50) NULL,
    [drvSalAmt] varchar(50) NULL,
    [drvClassEffDate] varchar(50) NULL,
    [drvClassID] varchar(4) NULL,
    [drvRateEffDate] varchar(1) NOT NULL,
    [drvSmoker] varchar(1) NOT NULL,
    [drvDentalLateEntrant] varchar(1) NOT NULL,
    [drvDentProdCatD] varchar(50) NULL,
    [drvDentEffDateD] varchar(50) NULL,
    [drvDentEligEventD] varchar(50) NULL,
    [drvDentPlanIDD] varchar(50) NULL,
    [drvDentFamCovD] varchar(50) NULL,
    [drvProdCat1] varchar(50) NULL,
    [drvEffDate1] varchar(50) NULL,
    [drvEligEvent1] varchar(50) NULL,
    [drvPlanID1] varchar(50) NULL,
    [drvFamCov1] varchar(50) NULL,
    [drvProdCata] varchar(50) NULL,
    [drvEffDatea] varchar(50) NULL,
    [drvEligEventa] varchar(50) NULL,
    [drvPlanIDa] varchar(50) NULL,
    [drvFamCova] varchar(50) NULL,
    [drvProdCatS] varchar(50) NULL,
    [drvEffDateS] varchar(50) NULL,
    [drvEligEventS] varchar(50) NULL,
    [drvPlanIDS] varchar(50) NULL,
    [drvFamCovS] varchar(50) NULL,
    [drvProdCatT] varchar(50) NULL,
    [drvEffDateT] varchar(50) NULL,
    [drvEligEventT] varchar(50) NULL,
    [drvPlanIDT] varchar(50) NULL,
    [drvFamCovT] varchar(50) NULL,
    [drvNomEffDateT] varchar(50) NULL,
    [drvNomAmtT] varchar(50) NULL,
    [drvProdCat3] varchar(50) NULL,
    [drvEffDate3] varchar(50) NULL,
    [drvEligEvent3] varchar(50) NULL,
    [drvPlanID3] varchar(50) NULL,
    [drvFamCov3] varchar(50) NULL,
    [drvNomEffDate3] varchar(50) NULL,
    [drvNomAmt3] varchar(50) NULL,
    [drvProdCat4] varchar(50) NULL,
    [drvEffDate4] varchar(50) NULL,
    [drvEligEvent4] varchar(50) NULL,
    [drvPlanID4] varchar(50) NULL,
    [drvFamCov4] varchar(50) NULL,
    [drvNomEffDate4] varchar(50) NULL,
    [drvNomAmt4] varchar(50) NULL,
    [drvProdCat5] varchar(50) NULL,
    [drvEffDate5] varchar(50) NULL,
    [drvEligEvent5] varchar(50) NULL,
    [drvPlanID5] varchar(50) NULL,
    [drvFamCov5] varchar(50) NULL,
    [drvNomEffDate5] varchar(50) NULL,
    [drvNomAmt5] varchar(50) NULL,
    [drvProdCatc] varchar(50) NULL,
    [drvEffDatec] varchar(50) NULL,
    [drvEligEventc] varchar(50) NULL,
    [drvPlanIDc] varchar(50) NULL,
    [drvFamCovc] varchar(50) NULL,
    [drvNomEffDatec] varchar(50) NULL,
    [drvNomAmtc] varchar(50) NULL,
    [drvProdCate] varchar(50) NULL,
    [drvEffDatee] varchar(50) NULL,
    [drvEligEvente] varchar(50) NULL,
    [drvPlanIDe] varchar(50) NULL,
    [drvFamCove] varchar(50) NULL,
    [drvNomEffDatee] varchar(50) NULL,
    [drvNomAmte] varchar(50) NULL,
    [drvProdCatd] varchar(50) NULL,
    [drvEffDated] varchar(50) NULL,
    [drvEligEventd] varchar(50) NULL,
    [drvPlanIDd] varchar(50) NULL,
    [drvFamCovd] varchar(50) NULL,
    [drvNomEffDated] varchar(50) NULL,
    [drvNomAmtd] varchar(50) NULL,
    [drvProdCatQ] varchar(50) NULL,
    [drvEffDateQ] varchar(50) NULL,
    [drvEligEventQ] varchar(50) NULL,
    [drvPlanIDQ] varchar(50) NULL,
    [drvFamCovQ] varchar(50) NULL,
    [drvPriorSTDCovL] varchar(50) NULL,
    [drvProdCatL] varchar(50) NULL,
    [drvEffDateL] varchar(50) NULL,
    [drvEligEventL] varchar(50) NULL,
    [drvPlanIDL] varchar(50) NULL,
    [drvFamCovL] varchar(50) NULL,
    [drvProdCatR] varchar(50) NULL,
    [drvEffDateR] varchar(50) NULL,
    [drvEligEventR] varchar(50) NULL,
    [drvPlanIDR] varchar(50) NULL,
    [drvFamCovR] varchar(50) NULL,
    [drvProdCatAA] varchar(50) NULL,
    [drvEffDateAA] varchar(50) NULL,
    [drvEligEventAA] varchar(50) NULL,
    [drvPlanIDAA] varchar(50) NULL,
    [drvFamCovAA] varchar(50) NULL,
    [drvNomEffDateAA] varchar(50) NULL,
    [drvNomAmtAA] varchar(50) NULL,
    [drvProdCatJ] varchar(50) NULL,
    [drvEffDateJ] varchar(50) NULL,
    [drvEligEventJ] varchar(50) NULL,
    [drvPlanIDJ] varchar(50) NULL,
    [drvFamCovJ] varchar(50) NULL,
    [drvNomEffDateJ] varchar(50) NULL,
    [drvNomAmtJ] varchar(50) NULL,
    [drvProdCatg] varchar(50) NULL,
    [drvEffDateg] varchar(50) NULL,
    [drvEligEventg] varchar(50) NULL,
    [drvPlanIDg] varchar(50) NULL,
    [drvFamCovg] varchar(50) NULL,
    [drvNomEffDateg] varchar(50) NULL,
    [drvNomAmtg] varchar(50) NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EMUTOMHTR2_BDM') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EMUTOMHTR2_BDM] (
    [BdmBenStartDate] datetime NULL,
    [BdmBenStopDate] datetime NULL,
    [BdmCOID] char(5) NULL,
    [BdmDedCode] char(5) NULL,
    [BdmEEAmt] money NULL,
    [BdmEEID] char(12) NOT NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EMUTOMHTR2_Coverage') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EMUTOMHTR2_Coverage] (
    [BdmBenStartDate] datetime NULL,
    [BdmBenStopDate] datetime NULL,
    [BdmCOID] char(5) NULL,
    [BdmDedCode] char(5) NULL,
    [BdmRelationship] char(3) NULL,
    [BdmEEAmt] money NULL,
    [BdmEEID] char(12) NOT NULL,
    [BdmBenOption] char(6) NULL,
    [BdmNumSpouses] int NULL,
    [BdmNumChildren] int NULL
);
IF OBJECT_ID('U_Dsi_DrvTbl_EMUTOMHTR2_Master') IS NULL
CREATE TABLE [dbo].[U_Dsi_DrvTbl_EMUTOMHTR2_Master] (
    [MstCOID] char(5) NULL,
    [MstEEID] char(12) NULL
);
IF OBJECT_ID('U_dsi_EMUTOMHTR2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EMUTOMHTR2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvTransDate] datetime NOT NULL,
    [drvGroupID] varchar(8) NOT NULL,
    [drvRelationship] varchar(1) NOT NULL,
    [drvSubscriberID] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvMI] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvEmpID] char(9) NULL,
    [drvAddress1] varchar(6000) NULL,
    [drvAddress2] varchar(6000) NULL,
    [drvAddress3] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZIP] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvWorkPhone] char(10) NULL,
    [drvWorkExt] varchar(1) NOT NULL,
    [drvDateOfHire] varchar(8) NULL,
    [drvEffDate] char(8) NULL,
    [drvMemberSSN] char(11) NULL,
    [drvFullTimeStudent] varchar(1) NOT NULL,
    [drvRelationshipDate] char(8) NULL,
    [drvSubgroupID] varchar(4) NOT NULL,
    [drvEmpDataSegDate] char(8) NULL,
    [drvOccupation] varchar(1) NOT NULL,
    [drvDept] varchar(1) NOT NULL,
    [drvLocID] varchar(1) NOT NULL,
    [drvLocDesc] varchar(1) NOT NULL,
    [drvSalEffDate] char(8) NULL,
    [drvSalMode] varchar(1) NOT NULL,
    [drvSalAmt] char(16) NULL,
    [drvClassEffDate] char(8) NULL,
    [drvClassID] varchar(4) NOT NULL,
    [drvRateEffDAte] varchar(1) NOT NULL,
    [drvSmoker] varchar(1) NOT NULL,
    [drvDentalLateEntrant] varchar(1) NOT NULL,
    [drvDentProdCatD] varchar(1) NULL,
    [drvDentEffDateD] char(8) NULL,
    [drvDentEligEventD] varchar(2) NOT NULL,
    [drvDentPlanIDD] varchar(10) NULL,
    [drvDentFamCovD] varchar(1) NULL,
    [drvProdCat1] varchar(1) NULL,
    [drvEffDate1] char(8) NULL,
    [drvEligEvent1] varchar(2) NOT NULL,
    [drvPlanID1] varchar(10) NULL,
    [drvFamCov1] varchar(1) NULL,
    [drvProdCata] varchar(1) NULL,
    [drvEffDatea] char(8) NULL,
    [drvEligEventa] varchar(2) NOT NULL,
    [drvPlanIDa] varchar(10) NULL,
    [drvFamCova] varchar(1) NULL,
    [drvNomEffDatea] varchar(1) NOT NULL,
    [drvNomAmta] varchar(1) NOT NULL,
    [drvProdCatS] varchar(1) NULL,
    [drvEffDateS] char(8) NULL,
    [drvEligEventS] varchar(2) NOT NULL,
    [drvPlanIDS] varchar(10) NULL,
    [drvFamCovS] varchar(1) NULL,
    [drvProdCatT] varchar(1) NULL,
    [drvEffDateT] char(8) NULL,
    [drvEligEventT] varchar(2) NOT NULL,
    [drvPlanIDT] varchar(10) NULL,
    [drvFamCovT] varchar(1) NULL,
    [drvNomEffDateT] varchar(1) NOT NULL,
    [drvNomAmtT] varchar(1) NOT NULL,
    [drvProdCat3] varchar(1) NULL,
    [drvEffDate3] varchar(8) NULL,
    [drvEligEvent3] varchar(2) NOT NULL,
    [drvPlanID3] varchar(10) NULL,
    [drvFamCov3] varchar(1) NULL,
    [drvNomEffDate3] varchar(8) NULL,
    [drvNomAmt3] varchar(24) NULL,
    [drvProdCat4] varchar(1) NULL,
    [drvEffDate4] varchar(8) NULL,
    [drvEligEvent4] varchar(2) NOT NULL,
    [drvPlanID4] varchar(10) NULL,
    [drvFamCov4] varchar(1) NULL,
    [drvNomEffDate4] varchar(8) NULL,
    [drvNomAmt4] varchar(24) NULL,
    [drvProdCat5] varchar(1) NULL,
    [drvEffDate5] varchar(8) NULL,
    [drvEligEvent5] varchar(2) NOT NULL,
    [drvPlanID5] varchar(10) NULL,
    [drvFamCov5] varchar(1) NULL,
    [drvNomEffDate5] varchar(8) NULL,
    [drvNomAmt5] varchar(24) NULL,
    [drvProdCatc] varchar(1) NULL,
    [drvEffDatec] varchar(8) NULL,
    [drvEligEventc] varchar(2) NOT NULL,
    [drvPlanIDc] varchar(10) NULL,
    [drvFamCovc] varchar(1) NULL,
    [drvNomEffDatec] varchar(8) NULL,
    [drvNomAmtc] varchar(24) NULL,
    [drvProdCate] varchar(1) NULL,
    [drvEffDatee] varchar(8) NULL,
    [drvEligEvente] varchar(2) NOT NULL,
    [drvPlanIDe] varchar(10) NULL,
    [drvFamCove] varchar(1) NULL,
    [drvNomEffDatee] varchar(8) NULL,
    [drvNomAmte] varchar(24) NULL,
    [drvProdCatd] varchar(1) NULL,
    [drvEffDated] varchar(8) NULL,
    [drvEligEventd] varchar(2) NOT NULL,
    [drvPlanIDd] varchar(10) NULL,
    [drvFamCovd] varchar(1) NULL,
    [drvNomEffDated] varchar(8) NULL,
    [drvNomAmtd] varchar(24) NULL
);
IF OBJECT_ID('U_EMUTOMHTR2_Audit') IS NULL
CREATE TABLE [dbo].[U_EMUTOMHTR2_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EMUTOMHTR2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMUTOMHTR2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EMUTOMHTR2_EEList') IS NULL
CREATE TABLE [dbo].[U_EMUTOMHTR2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMUTOMHTR2_File') IS NULL
CREATE TABLE [dbo].[U_EMUTOMHTR2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMUTOMHTR2]
 @SystemID VARCHAR(12) = ''

AS
BEGIN

/**********************************************************************************
Client Name: Triage, LLC
Created By: Vraj Parikh
Business Analyst: Bettye Haynes
Create Date: 1/22/2020
Service Request Number: TRI1026-2019-00258233

Purpose: Mutual of Omaha Benefits Export

Revision History
----------------
Update By            Date            Request Num                Desc
XXXX                 XX/XX/16        SR-2016-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMUTOMHTR2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMUTOMHTR2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMUTOMHTR2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EMUTOMHTR2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMUTOMHTR2' ORDER BY DateTimeCompleted DESC;

Execute Export
--------------

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMUTOMHTR2', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMUTOMHTR2', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMUTOMHTR2', @AllObjects = 'Y', @IsWeb = 'Y'

SELECT * FROM dbo.AscDeff WHERE adfHeaderSystemID LIKE '%EMUTOMHTR2Z0%'
ORDER BY AdfSetNumber, AdfFieldNumber


**********************************************************************************/

-----------
-- Collect date parameters
-----------

DECLARE 

@StartDate       DATETIME,
@EndDate         DATETIME,
@StartPerControl CHAR(9),
@EndPerControl   CHAR(9),
@FormatCode      CHAR(10),
@ExportCode      CHAR(10),
@ExportFile      CHAR(200)

SELECT 

@StartDate       = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
@EndDate         = DATEADD(SS, -1, DATEADD(DD, 1, LEFT(EndPerControl, 8))), -- 11:59 PM
@StartPerControl = StartPerControl,
@EndPerControl   = EndPerControl,
@FormatCode      = RTRIM(FormatCode),
@ExportCode      = ExportCode,
@Exportfile      = ExportFile

FROM dbo.U_dsi_Parameters WITH (NOLOCK)
WHERE formatcode = 'EMUTOMHTR2'

-----------
-- Declare and set variables
-----------

DECLARE @PlanDate DATETIME

SET @PlanDate = '01/01/2021' --'12/01/2019' --'05/01/2018' 

-- Set "Floor" date for elections / min coverage date
 
Update dbo.U_dsi_bdm_EmpDeductions
   Set EedBenStartDate = @PlanDate -- '12/01/2019'
 Where isnull(EedBenStopDate,GetDate()) >= @PlanDate--'12/01/2019'
   and EedBenStartDate< @PlanDate--'12/01/2019' 
   and EedFormatCode = @FormatCode 
Update dbo.U_dsi_bdm_EmpDeductions 
   Set Eedvalidforexport = 'N' 
 Where EedBenStopDate < @PlanDate--'12/01/2019' 
   and EedFormatCode = @FormatCode 
Update dbo.U_dsi_bdm_DepDeductions
   Set DbnBenStartDate = @PlanDate --'12/01/2019'
 Where isnull(DbnBenStopDate,GetDate()) >= @PlanDate--'12/01/2019'
   and DbnBenStartDate < @PlanDate--'12/01/2019' 
   and DbnFormatCode = @FormatCode 
Update dbo.U_dsi_bdm_DepDeductions 
   Set Dbnvalidforexport = 'N' 
 Where DbnBenStopDate < @PlanDate--'12/01/2019' 
   and DbnFormatCode = @FormatCode
-----------
-- Drop Tables
-----------

IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EMUTOMHTR2')             IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EMUTOMHTR2
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master')      IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage')    IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage

-----------
-- Set test EEID
-----------

--DELETE FROM U_EMUTOMHTR2_EEList WHERE xEEID <> 'B5EOE50000K0'

-----------
-- Populate BDM
-----------

DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes', 'LIFEE,LIFES,LIFEC,STD40,STD60')   
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'BuildConsolidatedTable', 'Standard')
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime', @StartDate)
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime', @EndDate)
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CountDependents','Y')
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse','SPS,DOM,DP,FIA,XSP')
INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild','CHL,DPC,STC,DIS')

IF @ExportCode = 'OEPASSIVE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')
END

IF @ExportCode = 'OEACTIVE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active')
END

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

--Spouse/Domestic Partner:
    INSERT INTO dbo.U_dsi_bdm_DepDeductions (dbnformatcode, dbncoid, dbneeid, dbndeprecid, DbnRelationship, dedeebenamt, dbnbenoption, dbnbenstatus, dbnbenstartdate, dbnbenstopdate, dbndedcode, dbnvalidforexport, deddedcode, deddedtype)
      (SELECT eedformatcode, ee.eedcoid, ee.eedeeid, consystemid, conrelationship, ee.eedbenamt, ee.eedbenoption, ee.eedbenstatus, ee.eedbenstartdate, ee.eedbenstopdate, ee.eeddedcode, ee.eedvalidforexport, ee.eeddedcode, ee.deddedtype
    FROM empded ed JOIN emppers WITH (NOLOCK) ON eepeeid = ed.eedeeid
    JOIN dbo.u_dsi_bdm_EmpDeductions ee WITH (NOLOCK) ON ee.eedeeid = ed.eedeeid AND ee.eedcoid = ed.eedcoid
        AND eedFormatCode = 'EMUTOMHTR2' AND eedValidForExport = 'Y'
        AND ee.eeddedcode = ed.eeddedcode
    JOIN contacts WITH (NOLOCK) ON eedDepRecID = consystemid
    WHERE ee.eeddedcode in ('LIFES') AND conrelationship in ('DP','SPS'))

--Child:
    INSERT INTO dbo.U_dsi_bdm_DepDeductions (dbnformatcode, dbncoid, dbneeid, dbndeprecid, DbnRelationship, dedeebenamt, dbnbenoption, dbnbenstatus, dbnbenstartdate, dbnbenstopdate, dbndedcode, dbnvalidforexport, deddedcode, deddedtype)
      (SELECT eedformatcode, ee.eedcoid, ee.eedeeid, consystemid, conrelationship, ee.eedbenamt, ee.eedbenoption, ee.eedbenstatus, ee.eedbenstartdate, ee.eedbenstopdate, ee.eeddedcode, ee.eedvalidforexport, ee.eeddedcode, ee.deddedtype
    FROM empded ed JOIN emppers WITH (NOLOCK) ON eepeeid = ed.eedeeid
    JOIN dbo.u_dsi_bdm_EmpDeductions ee WITH (NOLOCK) ON ee.eedeeid = ed.eedeeid AND ee.eedcoid = ed.eedcoid
        AND eedFormatCode = 'EMUTOMHTR2' AND eedValidForExport = 'Y'
        AND ee.eeddedcode = ed.eeddedcode
    JOIN contacts WITH (NOLOCK) ON eedDepRecID = consystemid
    WHERE ee.eeddedcode in ('LIFEC') AND conrelationship in ('CHL'))

-----------
-- Reduce EEList to employees with benefits
-----------

DELETE FROM dbo.U_EMUTOMHTR2_EEList

INSERT INTO U_EMUTOMHTR2_EEList
SELECT DISTINCT dbo.dsi_fn_GetCurrentCOID(BdmEEID), BDmEEID FROM U_dsi_bdm_EMUTOMHTR2

   ----==========================================
   -- -- Clean EE List 
   -- -- Caution: Careful of cleaning EE List if including paycheck data
   -- --==========================================

   -- -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
   -- DELETE FROM dbo.U_EMUTOMHTR2_EEList
   -- WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
   -- AND xEEID IN (SELECT xEEID FROM dbo.U_EMUTOMHTR2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);






    











-----------
-- Create master table for employees
-----------

CREATE TABLE [dbo].[U_Dsi_DrvTbl_EMUTOMHTR2_Master](
  [MstCOID]             CHAR(5)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [MstEEID]             CHAR(12)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

INSERT INTO dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
SELECT DISTINCT dbo.dsi_fn_GetCurrentCOID(BdmEEID), BDmEEID FROM U_dsi_bdm_EMUTOMHTR2

-----------
-- Create coverage table for employees
-----------

SELECT distinct BdmBenStartDate, BdmBenStopDate, BdmCOID, BdmDedCode,BdmRelationship, BdmEEAmt, BdmEEID,BdmBenOption, BdmNumSpouses, BdmNumChildren               --2/20/17 added distinct

INTO dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage
FROM U_dsi_bdm_EMUTOMHTR2
Where BdmBenStartDate is not Null

-----------
-- Update coverage table with benefit amounts
-----------

EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

UPDATE dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage
   SET BdmEEAmt = (bcaBenAmtCalc)
  FROM dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage
  JOIN dbo.u_dsi_bdm_BenCalculationAmounts ON bcaFormatCode = @FormatCode AND bcaEEID = bdmEEID AND bcaCOID = bdmCOID AND bcaDedCode = bdmDedCode and BcaDepRecID IS NULL

-----------
-- Clean up EE data
-----------

delete dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
--select * 
from dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
join emppers on eepeeid = msteeid
where (left(eepssn,5) = '99999') or eepssn = '111223344'


--==========================================
    -- Remove Test Employees
--==========================================
    DELETE dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
    FROM dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
    JOIN EmpPers t WITH (NOLOCK) ON Msteeid = eepeeid 
    WHERE t.EepNameLast like 'Employee%' OR t.EepNameFirst like 'Test%';

--==========================================
    -- Remove Employees with these Job Codes
--==========================================
    DELETE dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
    FROM dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
    JOIN vw_int_EmpComp c WITH (NOLOCK) ON Msteeid = eeceeid 
    WHERE c.EecJobCode IN ('XXXX', 'XXX', 'XXX');

--==========================================
-- Remove Terminated Employees greater than 1 year
--==========================================
DELETE dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
FROM dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
JOIN vw_int_EmpComp t WITH (NOLOCK) ON Msteeid = eeceeid 
WHERE EecEmplStatus ='T' AND EECEEID = dbo.dsi_BDM_fn_GetCurrentCOID(EecEEID) AND DATEDIFF(DAY,t.EecDateOfTermination,@EndDate) > 365 ;


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMUTOMHTR2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMUTOMHTR2_AuditFields;
    CREATE TABLE dbo.U_EMUTOMHTR2_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EMUTOMHTR2_AuditFields VALUES ('EmpComp','EecLocation');
    
    --INSERT INTO dbo.U_EMUTOMHTR2_AuditFields VALUES ('JobCode','JbcUDField1');

    --sp_help empcomp

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMUTOMHTR2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMUTOMHTR2_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)        
    INTO dbo.U_EMUTOMHTR2_Audit        -- select * from dbo.U_EMUTOMHTR2_Audit where audeeid = '9RS27T0000K0' audftptchg = 'Y'        sp_geteeid '0988522'
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master
        ON MstEEID = audKey1Value
    JOIN dbo.U_EMUTOMHTR2_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    ;

    DELETE dbo.U_EMUTOMHTR2_Audit WHERE audRowNo <> 1;


-----------
-- Build driver table
-----------

IF OBJECT_ID('dbo.U_Dsi_DrvTbl_EMUTOMHTR2')             
IS NOT NULL  DROP TABLE dbo.U_Dsi_DrvTbl_EMUTOMHTR2

SELECT DISTINCT

DrvCOID              = MstCOID,
DrvEEID              = MstEEID,
DrvDepID             = CONVERT(VARCHAR,NULL),
drvTransDate         = CONVERT(CHAR(8), GETDATE(), 112),
drvGroupID           = 'G000BV8F',--'G000B8YT',
drvRelationship      = CAST('M'  AS VARCHAR (50)),
drvSubscriberID      = EepSSN,
drvNameLast          = CAST(ltrim(rtrim(EepNameLast)) AS VARCHAR(50)),
drvNameFirst         = CAST(ltrim(rtrim(EepNameFirst))AS VARCHAR (50)),
drvNameMiddle        = LEFT(EepNameMiddle, 1),
drvGender            = CASE EepGender WHEN 'M' THEN 'M' WHEN 'F' THEN 'F' ELSE 'U' END,
drvDateOfBirth       = CONVERT(CHAR(8), EepDateOfBirth, 112),
drvMaritalStatus     = '', --EepMaritalStatus,
drvEmpID             = '', --EecEmpNo,
drvAddressLine1      = CAST (dbo.dsi_fnRemoveChars('.,/-#*&', EepAddressLine1)AS VARCHAR(50)),
drvAddressLine2      = CAST (dbo.dsi_fnRemoveChars('.,/-#*&', EepAddressLine2) AS VARCHAR (50)),
drvAddress3          = '',
drvAddressCity       = CAST(EepAddressCity AS VARCHAR (60)),
drvAddressState      = CAST (EepAddressState  AS VARCHAR (50)),
drvZIP               = CAST(EepAddressZipCode AS VARCHAR (50)),
drvCountry           = '',--EepAddressCountry,
drvHomePhone         = '', --CAST (EepPhoneHomeNumber  AS VARCHAR (50)),
drvWorkPhone         = '', --CAST(EecPhoneBusinessNumber  AS VARCHAR (50)),
drvWorkExt           = '',
drvDateOfHire        = CAST(CONVERT(VARCHAR(8), EecDateOforiginalHire, 112) AS VARCHAR (50)),
drvEffDate           = CAST(CASE 
                          WHEN EecDateOfLastHire < @PlanDate THEN CONVERT(CHAR(8), @PlanDate, 112)
                          ELSE CONVERT(VARCHAR(8), EecDateOfLastHire, 112) 
                       END  AS VARCHAR (50)),
drvMemberSSN         = '', --CAST (EepSSN  AS VARCHAR (50)),
drvFullTimeStudent   = '',
drvRelationshipDate  = CAST (CASE 
                          WHEN EecDateOfLastHire < @PlanDate THEN CONVERT(CHAR(8), @PlanDate, 112)
                          ELSE CONVERT(VARCHAR(8), EecDateOfLastHire, 112) 
                       END  AS VARCHAR (50)),
drvSubgroupID        = CAST ('0001'  AS VARCHAR (50)),
-- the name of EmpDataSegDate was changed to location effective date in the new mapping
drvEmpDataSegDate    = dbo.dsi_fnGetMinMaxDates('MAX', audDateTime, '1/1/2021'),
                        --CONVERT(VARCHAR(8), EecDateOfLastHire, 112),
                       -- CAST(CASE                                                           
                       --   WHEN EecDateOfLastHire < @PlanDate THEN CONVERT(CHAR(8), @PlanDate, 112)
                       --   ELSE CONVERT(VARCHAR(8), EecDateOfLastHire, 112) 
                       --END  AS VARCHAR (50)),
drvOccupation        = '',
drvDept              = '',
drvLocID             = CASE WHEN EecLocation = 'NE000' THEN '02' ELSE '01' END,--eecOrgLvl1,
drvLocDesc           = CASE WHEN EecLocation = 'NE000' THEN 'Corporate' ELSE 'Field' END,--o1.orgDesc,
drvDateofLastHire    = EecDateofLastHire,
drvSalEffDate        = CONVERT(CHAR(8), ''), -- This is being updated after the table gets created
drvSalMode           = CAST ('A'  AS VARCHAR (50)),
drvSalAmt            = CASE WHEN ISNULL(EecAnnSalary,0) <> 0 THEN CAST( convert(varchar,(dbo.dsi_fnPadZero(EecAnnSalary * 100, 16, 0)))  AS VARCHAR (50)) END,
drvClassEffDate      = CAST(CASE 
                          WHEN EecDateOfLastHire < @PlanDate THEN CONVERT(CHAR(8), @PlanDate, 112)
                          ELSE CONVERT(VARCHAR(8), EecDateOfLastHire, 112) 
                       END  AS VARCHAR (50)), -- EecDateInJob

drvClassID           =  CASE WHEN EecPayGroup IN ('BIWKLY','MNLY') AND vstd.BdmDedCode = 'STD40' THEN 'A001'
                             WHEN EecPayGroup IN ('BIWKLY','MNLY') AND vstd.BdmDedCode = 'STD60' THEN 'A002'
                             WHEN EecPayGroup IN ('BIWKLY','MNLY') AND vstd.BdmDedCode IS NULL THEN 'A004'
                             WHEN EecPayGroup = 'WKLY' THEN 'A003'
                             END,
                             
drvRateEffDate       =  '', 
                      --CAST (CASE 
     --                     WHEN EecDateOfLastHire < @PlanDate THEN CONVERT(CHAR(8), @PlanDate, 112)
     --                     ELSE CONVERT(VARCHAR(8), EecDateOfLastHire, 112) 
     --                  END  AS VARCHAR (50)),
drvSmoker            = '', --CAST (EepIsSmoker  AS VARCHAR (50)),

-- D: Dental
drvDentalLateEntrant = '', -- For employees covered by the prior carrier, provide a 'N' so that the Dental Benefit Waiting Period will NOT apply. Provide a 'Y' for all other employees
drvDentProdCatD      =  CAST(CASE WHEN dental.BdmDedCode IS NOT NULL THEN 'D' ELSE '' END  AS VARCHAR (50)),
drvDentEffDateD      =  CAST(CASE
                          WHEN dental.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), dental.BdmBenStopDate + 1, 112)
                          WHEN dental.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN dental.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), dental.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvDentEligEventD    = CAST(CASE
                          WHEN dental.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN dental.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvDentPlanIDD       = CAST(Case 
                       WHEN dental.BdmDedCode IS NOT NULL then CASE WHEN EepAddressState = 'TX' THEN 'WTP0001300' ELSE 'WTP0004900' END  
                       END  AS VARCHAR (50)),
drvDentFamCovD       = CAST(CASE WHEN dental.BdmDedCode IS NOT NULL THEN
                            CASE WHEN dental.BdmBenOption ='EE' THEN 'C'
                                 WHEN dental.BdmBenOption = 'EE1D' AND  dental.BdmNumSpouses <> 0 AND dental.BdmNumChildren = 0 THEN 'B'    
                                 WHEN dental.BdmBenOption = 'EE1D' AND  dental.BdmNumSpouses = 0 AND dental.BdmNumChildren <> 0 THEN 'D'
                                 WHEN dental.BdmBenOption = 'EE2D' THEN 'A'    --'A'
                                 WHEN dental.BdmBenOption = 'EEC' THEN 'D'
                                 When dental.BdmBenOption = 'EES' THEN 'B'
                                 ELSE 'A' END        
                                 ELSE '' END  AS VARCHAR (50)),
/*
EE + 1 Child = D 
EE + 1 Spouse = B 
EE + 2 or more dependents = D 
EE only = C 
EE + Spouse and more dependents / family = A 
*/
-- 1: Basic life

drvProdCat1          = CAST(CASE WHEN basiclife.BdmDedCode IS NOT NULL THEN '1' ELSE '' END AS VARCHAR (50)),
drvEffDate1          = CAST(CASE
                          WHEN basiclife.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), basiclife.BdmBenStopDate + 1, 112)
                          WHEN basiclife.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN basiclife.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), basiclife.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEvent1        = CAST(CASE
                          WHEN basiclife.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN basiclife.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanID1           = 
 CAST(Case 
                       WHEN basiclife.BdmDedCode IS NOT NULL then 
                       CASE WHEN EepAddressState = 'TX' THEN  'LTL0NCFLAT' 
                            WHEN EepAddressState <> 'TX'  THEN 'LTL00NCSAL'
                                 END
                            ELSE ''  
                       END  AS VARCHAR (50)),

    
drvFamCov1           = CAST(CASE WHEN basiclife.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),

-- a: Basic AD&D

drvProdCata          = CAST(CASE WHEN basicADD.BdmDedCode IS NOT NULL THEN 'a' ELSE '' END  AS VARCHAR (50)),
drvEffDatea          = CAST(CASE
                          WHEN basicADD.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), basicADD.BdmBenStopDate + 1, 112)
                          WHEN basicADD.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN basicADD.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), basicADD.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEventa        = CAST(CASE
                          WHEN basicADD.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN basicADD.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanIDa           =CAST(CASE 
                            WHEN basicADD.BdmDedCode IS NOT NULL  THEN 'ATA00NCSAL'
                            ELSE ''  
                       END  AS VARCHAR (50)),
drvFamCova           = CAST(CASE WHEN basicADD.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),

-- S: Basic STD

drvProdCatS          = CAST(CASE WHEN basicSTD.BdmDedCode IS NOT NULL THEN 'S' ELSE '' END  AS VARCHAR (50)),
drvEffDateS          = CAST(CASE WHEN basicSTD.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), basicSTD.BdmBenStopDate + 1, 112)
                                WHEN basicSTD.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                                WHEN basicSTD.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), basicSTD.BdmBenStartDate, 112)
                                ELSE NULL
                       END  AS VARCHAR (50)), 
drvEligEventS        = CAST( CASE 
                          WHEN basicSTD.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN basicSTD.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                
                       END  AS VARCHAR (50)), 
drvPlanIDS           = 
CAST(CASE WHEN basicSTD.BdmDedCode IS NOT NULL  THEN
       
         CASE WHEN EepAddressState = 'TX' 
                              THEN 'JTS0NCFLAT'
                                 
                            WHEN EepAddressState <> 'TX' 
                              THEN 'JTS0NCFLA1'
                                END
                                    END AS VARCHAR (50)),
                       
drvFamCovS           = CAST(CASE WHEN basicSTD.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),

-- T: Basic LTD

drvProdCatT          = CAST(CASE WHEN basicLTD.BdmDedCode IS NOT NULL THEN 'T' ELSE '' END  AS VARCHAR (50)),
drvEffDateT          = CAST(CASE
                          WHEN basicLTD.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), basicLTD.BdmBenStopDate + 1, 112)
                          WHEN basicLTD.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN basicLTD.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), basicLTD.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEventT        = CAST(CASE
                          WHEN basicLTD.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN basicLTD.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanIDT           = CAST(CASE WHEN basicLTD.BdmDedCode IS NOT NULL THEN 'TTT00NCSAL' ELSE '' END  AS VARCHAR (50)),
drvFamCovT           = CAST(CASE WHEN basicLTD.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvNomEffDateT       = CAST(''  AS VARCHAR (50)), 
drvNomAmtT           = CAST(''  AS VARCHAR (50)),

-- 3: Voluntary Term Life Coverage Member

drvProdCat3          = CAST(CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN '3' ELSE '' END  AS VARCHAR (50)),
drvEffDate3          = CAST(CASE
                          WHEN supplEE.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), supplEE.BdmBenStopDate + 1, 112)
                          WHEN supplEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplEE.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEvent3        = CAST(CASE
                          WHEN supplEE.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN supplEE.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanID3           = CAST(CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN 'ETL0CEEVAL' ELSE '' END  AS VARCHAR (50)),
drvFamCov3           = CAST(CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvNomEffDate3       = CAST(CASE
                          WHEN supplEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplEE.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),
drvNomAmt3           = CAST(CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplEE.BdmEEAmt, 10, 0) ELSE '' END AS VARCHAR (50)), 

-- 4: Voluntary Term Life Coverage Spouse

drvProdCat4          = CAST( CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN '4' ELSE '' END  AS VARCHAR (50)),
drvEffDate4          = CAST (CASE
                          WHEN supplSP.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), supplSP.BdmBenStopDate + 1, 112)
                          WHEN supplSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplSP.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEvent4        = CAST(CASE
                          WHEN supplSP.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN supplSP.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanID4           = CAST(CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN 'ETL0CSPVAL' ELSE '' END  AS VARCHAR (50)),
drvFamCov4           = CAST(CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvNomEffDate4       = CAST(CASE
                          WHEN supplSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplSP.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),
drvNomAmt4           = CAST(CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplSP.BdmEEAmt, 10, 0) ELSE '' END  AS VARCHAR (50)),

-- 5: Voluntary Term Life Coverage Child

drvProdCat5          = CAST(CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN '5' ELSE '' END  AS VARCHAR (50)),
drvEffDate5          = CAST(CASE
                          WHEN supplCH.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), supplCH.BdmBenStopDate + 1, 112)
                          WHEN supplCH.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplCH.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplCH.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEvent5        = CAST(CASE
                          WHEN supplCH.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN supplCH.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanID5           = CAST(CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN 'ETL0CDPVAL' ELSE '' END  AS VARCHAR (50)),
drvFamCov5           = CAST(CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvNomEffDate5       = CAST(CASE
                          WHEN supplCH.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplCH.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplCH.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),
drvNomAmt5           = CAST( CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplCH.BdmEEAmt, 10, 0) ELSE '' END  AS VARCHAR (50)),


-- c: Voluntary AD&D Coverage employee

drvProdCatc          = CAST(CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN 'c' ELSE '' END  AS VARCHAR (50)),
drvEffDatec          =  CAST(CASE
                          WHEN supplEE.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), supplEE.BdmBenStopDate + 1, 112)
                          WHEN supplEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplEE.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),    
drvEligEventc        = CAST(CASE
                          WHEN supplEE.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN supplEE.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanIDc           = CAST(CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN 'BTA0CEEVAL' ELSE '' END  AS VARCHAR (50)),
drvFamCovc           = CAST(CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvNomEffDatec       = CAST(CASE
                          WHEN supplEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplEE.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),
drvNomAmtc           = CAST( CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplEE.BdmEEAmt, 10, 0) ELSE '' END  AS VARCHAR (50)),

-- e: Voluntary AD&D Coverage Spouse

drvProdCate          = CAST( CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN 'e' ELSE '' END  AS VARCHAR (50)),
drvEffDatee          = CAST (CASE
                          WHEN supplSP.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), supplSP.BdmBenStopDate + 1, 112)
                          WHEN supplSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplSP.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)), 
drvEligEvente        =CAST(CASE
                          WHEN supplSP.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN supplSP.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)), 
drvPlanIDe           = CAST(CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN 'BTA0CSPVAL' ELSE '' END  AS VARCHAR (50)),
drvFamCove           = CAST(CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvNomEffDatee       = CAST(CASE
                          WHEN supplSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplSP.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),
drvNomAmte           = CAST( CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplSP.BdmEEAmt, 10, 0) ELSE '' END  AS VARCHAR (50)),

-- d: Voluntary AD&D Coverage Dependent

drvProdCatd          =  CAST(CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN 'd' ELSE '' END  AS VARCHAR (50)),
drvEffDated          =  CAST (CASE
                          WHEN supplCH.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), supplCH.BdmBenStopDate + 1, 112)    --supplSP
                          WHEN supplCH.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplCH.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplCH.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),    
drvEligEventd        =  CAST(CASE
                          WHEN supplCH.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN supplCH.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),    
drvPlanIDd           = CAST(CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN 'BTA0CDPVAL' ELSE '' END  AS VARCHAR (50)),
drvFamCovd           = CAST(CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvNomEffDated       = CAST(CASE
                          WHEN supplCH.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplCH.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplCH.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),
drvNomAmtd           =  CAST( CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplCH.BdmEEAmt, 10, 0) ELSE '' END  AS VARCHAR (50)),

-- Q: STD

drvProdCatQ          = CAST(CASE WHEN vstd.BdmDedCode IS NOT NULL THEN 'Q' ELSE '' END  AS VARCHAR (50)),
drvEffDateQ          =CAST( CASE
                          WHEN vstd.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), vstd.BdmBenStopDate + 1, 112)
                          WHEN vstd.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN vstd.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), vstd.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEventQ        = CAST(CASE
                          WHEN vstd.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN vstd.BdmDedCode IS NOT NULL  THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanIDQ           = CAST(CASE WHEN vstd.BdmDedCode IS NOT NULL THEN 'YTS000CSAL' ELSE '' END  AS VARCHAR (50)),
drvFamCovQ           = CAST(CASE WHEN vstd.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvPriorSTDCovL      = CAST(''  AS VARCHAR (50)),

-- L: LTD

drvProdCatL          = CAST(CASE WHEN ltd.BdmDedCode IS NOT NULL THEN 'L' ELSE '' END  AS VARCHAR (50)),
drvEffDateL          = CAST(CASE
                          WHEN ltd.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), ltd.BdmBenStopDate + 1, 112)
                          WHEN ltd.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN ltd.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), ltd.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEventL        = CAST(CASE
                          WHEN ltd.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN ltd.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                          END  AS VARCHAR (50)),
drvPlanIDL           =CAST( CASE WHEN ltd.BdmDedCode = 'LTD1'  THEN 'ZTT0CABSAL'
                            WHEN ltd.BdmDedCode = 'LTD2'  THEN 'ZTT000CSAL'  
                            ELSE '' END  AS VARCHAR (50)),
drvFamCovL           = CAST(CASE WHEN ltd.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),


drvProdCatR          = CAST(CASE WHEN std.BdmDedCode IS NOT NULL AND std.BdmDedCode = 'STD6' THEN 'R' ELSE '' END  AS VARCHAR (50)),
drvEffDateR          =CAST( CASE
                          WHEN std.BdmBenStopDate IS NOT NULL  AND std.BdmDedCode = 'STD6' THEN CONVERT(VARCHAR(8), std.BdmBenStopDate + 1, 112)
                          WHEN std.BdmBenStartDate < @PlanDate  AND std.BdmDedCode = 'STD6'THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN std.BdmBenStartDate IS NOT NULL AND std.BdmDedCode = 'STD6' THEN CONVERT(VARCHAR(8), std.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEventR        = CAST(CASE
                          WHEN std.BdmBenStopDate IS NOT NULL  AND std.BdmDedCode = 'STD6' THEN 'TM'
                          WHEN std.BdmDedCode IS NOT NULL AND std.BdmDedCode = 'STD6'   THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanIDR           = CAST(CASE WHEN std.BdmDedCode IS NOT NULL  AND std.BdmDedCode = 'STD6' THEN 'JTS00CFLAT' ELSE '' END  AS VARCHAR (50)),
drvFamCovR           = CAST(CASE WHEN std.BdmDedCode IS NOT NULL  AND std.BdmDedCode = 'STD6' THEN 'C' ELSE '' END  AS VARCHAR (50)),


-- A: Voluntary Employee/Children Critical Illness

drvProdCatAA         = CAST(CASE WHEN illnessEE.BdmDedCode IS NOT NULL THEN 'A' ELSE '' END  AS VARCHAR (50)),
drvEffDateAA         = CAST(CASE
                          WHEN illnessEE.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), illnessEE.BdmBenStopDate + 1, 112)
                          WHEN illnessEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN illnessEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), illnessEE.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEventAA       =CAST( CASE
                          WHEN illnessEE.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN illnessEE.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanIDAA          = CAST(CASE WHEN illnessEE.BdmDedCode IS NOT NULL THEN '3CI00EDVAB' ELSE '' END  AS VARCHAR (50)),
drvFamCovAA          = CAST(CASE WHEN illnessEE.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvNomEffDateAA      = CAST(CASE
                          WHEN illnessEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN illnessEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), illnessEE.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),
drvNomAmtAA          = CAST(CASE WHEN illnessEE.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(illnessEE.BdmEEAmt, 10, 0) ELSE '' END  AS VARCHAR (50)),

-- J:Voluntary Spouse Critical Illness

drvProdCatJ          = CAST(CASE WHEN illnessSP.BdmDedCode IS NOT NULL THEN 'J' ELSE '' END  AS VARCHAR (50)),
drvEffDateJ          = CAST(CASE
                          WHEN illnessSP.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), illnessSP.BdmBenStopDate + 1, 112)
                          WHEN illnessSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN illnessSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), illnessSP.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEventJ        =CAST( CASE
                          WHEN illnessSP.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN illnessSP.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanIDJ           = CAST(CASE WHEN illnessSP.BdmDedCode IS NOT NULL THEN '3CI00SPVAB' ELSE '' END  AS VARCHAR (50)),
drvFamCovJ           = CAST(CASE WHEN illnessSP.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
drvNomEffDateJ       = CAST(CASE
                          WHEN illnessSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN illnessSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), illnessSP.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),
drvNomAmtJ           = CAST(CASE WHEN illnessSP.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(illnessSP.BdmEEAmt, 10, 0) ELSE '' END  AS VARCHAR (50)),    


-- J:Voluntary Accident

drvProdCatg          = CAST(CASE WHEN accident.BdmDedCode IS NOT NULL THEN 'g' ELSE '' END  AS VARCHAR (50)),
drvEffDateg          = CAST(CASE
                          WHEN accident.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), accident.BdmBenStopDate + 1, 112)
                          WHEN accident.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN accident.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), accident.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEventg        = CAST(CASE
                          WHEN accident.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN accident.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanIDg           = CAST(CASE WHEN accident.BdmDedCode IS NOT NULL THEN '6AS000VACC' ELSE '' END  AS VARCHAR (50)),
drvFamCovg           = CAST(CASE WHEN accident.BdmDedCode IS NOT NULL THEN CASE
                       WHEN accident.BdmBenOption in ('EEF') then 'A'
                       WHEN accident.BdmBenOption in ('EES') then 'B'
                       WHEN accident.BdmBenOption in ('EE') then 'C'
                       WHEN accident.BdmBenOption in ('EEC') then 'D'
                       WHEN accident.BdmBenOption in ('EE1D') AND  accident.BdmNumSpouses <> 0 AND accident.BdmNumChildren = 0  then 'B'
                       WHEN accident.BdmBenOption in ('EE1D') AND  accident.BdmNumSpouses = 0 AND accident.BdmNumChildren <> 0  then 'D'
                       WHEN accident.BdmBenOption in ('EE2D') then 'A'
                       Else 'A' End    
                       ELSE '' END  AS VARCHAR (50)),

/*
EE + 1 Child = D 
EE + 1 Spouse = B 
EE + 2 or more dependents = D 
EE only = C 
EE + Spouse and more dependents / family = A 
*/

drvNomEffDateg       = CAST(''  AS VARCHAR (50)),
                       --CASE
        --                  WHEN accident.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
        --                  WHEN accident.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), accident.BdmBenStartDate, 112)
        --                  ELSE ''
        --               END,
drvNomAmtg           = CAST(CASE WHEN accident.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(accident.BdmEEAmt, 10, 0) ELSE '' END  AS VARCHAR (50))

INTO dbo.U_Dsi_DrvTbl_EMUTOMHTR2
FROM dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master WITH (NOLOCK)
JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = MstEEID
JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON EecCOID = MstCOID AND EecEEID = MstEEID
--JOIN U_dsi_bdm_EMUTOMHTR2 WITH (NOLOCK) ON BdmEEID = MstEEID and bdmcoid = mstCoid
--JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage ON BdmEEID = MstEEID and BdmCoid = mstCoid                     
LEFT JOIN dbo.dsi_fnlib_JobHistoryTable_v2('EjhJobCode') jc ON EEID = MstEEID and COID = MstCOID
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage dental    WITH (NOLOCK) ON dental.BdmDedCode in ('')    AND dental.BdmEEID = MstEEID    AND dental.BdmCOID = MstCOID  and  Dental.BDMRelationship ='EMP'
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage basiclife WITH (NOLOCK) ON basiclife.BdmDedCode in ('')     AND basiclife.BdmEEID = MstEEID AND basiclife.BdmCOID = MstCOID        
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage basicADD  WITH (NOLOCK) ON basicADD.BdmDedCode in ('')      AND basicADD.BdmEEID = MstEEID  AND basicADD.BdmCOID = MstCOID         
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage basicLTD  WITH (NOLOCK) ON basicLTD.BdmDedCode IN ('')              AND basicLTD.BdmEEID = MstEEID  AND basicLTD.BdmCOID = MstCOID  
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage basicSTD  WITH (NOLOCK) ON basicSTD.BdmDedCode IN ('')           AND basicSTD.BdmEEID = MstEEID  AND basicSTD.BdmCOID = MstCOID                
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage supplEE   WITH (NOLOCK) ON supplEE.BdmDedCode = 'LIFEE'                  AND supplEE.BdmEEID = MstEEID   AND supplEE.BdmCOID = MstCOID          
LEFT JOIN (SELECT MAX(BdmBenStartDate) BdmBenStartDate, BdmBenStopDate, BdmCOID, BdmDedCode, bdmBenOption,BdmEEID, MAX(BdmEEAmt) BdmEEAmt FROM dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage  WHERE BdmDedCode = 'LIFES'  GROUP BY  BdmBenStopDate, BdmCOID, BdmDedCode, BdmEEID, bdmBenOption) AS supplSP  ON  supplSP.BdmEEID = MstEEID   AND supplSP.BdmCOID = MstCOID -- AND supplSP.BdmRelationship = 'SPS'    --here    
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage supplCH   WITH (NOLOCK) ON supplCH.BdmDedCode = 'LIFEC'                  AND supplCH.BdmEEID = MstEEID   AND supplCH.BdmCOID = MstCOID  AND supplCH.BdmRelationship = 'EMP'
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage std       WITH (NOLOCK) ON std.BdmDedCode IN  ('')                     AND std.BdmEEID = MstEEID       AND std.BdmCOID = MstCOID   
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage ltd       WITH (NOLOCK) ON ltd.BdmDedCode IN  ('')                     AND ltd.BdmEEID = MstEEID       AND ltd.BdmCOID = MstCOID                           
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage vstd      WITH (NOLOCK) ON vstd.BdmDedCode IN  ('STD40','STD60')                     AND vstd.BdmEEID = MstEEID       AND vstd.BdmCOID = MstCOID     and vstd.BDMRelationship ='EMP' 
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage illnessEE WITH (NOLOCK) ON illnessEE.BdmDedCode in ('')         AND illnessEE.BdmEEID = MstEEID AND illnessEE.BdmCOID = MstCOID  and illnessEE.BDMRelationship ='EMP' --   and illnessEE.bdmeeamt is not null  -- REMOVED 'CIC'
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage illnessSP WITH (NOLOCK) ON illnessSP.BdmDedCode in ('')         AND illnessSP.BdmEEID = MstEEID AND illnessSP.BdmCOID = MstCOID   and illnessSp.BDMRelationship ='EMP'    --and illnessSP.bdmeeamt is not null 
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage accident  WITH (NOLOCK) ON accident.BdmDedCode in ('')                AND accident.BdmEEID = MstEEID AND accident.BdmCOID = MstCOID  and Accident.BDMRelationship ='EMP'
LEFT JOIN (select orglvl,orgDesc, orgCode from vw_int_OrgLevel ) o1 on o1.orgLvl = 1 and o1.orgCode = eecOrgLvl1
LEFT JOIN dbo.U_EMUTOMHTR2_Audit WITH (NOLOCK)
    ON MstEEID = audEEID
    AND MstCOID = audKey2

WHERE EXISTS (Select 1 from U_Dsi_DrvTbl_EMUTOMHTR2_Coverage Where bdmEEID = mstEEID)            






--Dependents

Insert INTO dbo.U_Dsi_DrvTbl_EMUTOMHTR2

SELECT DISTINCT

DrvCOID              = DrvCOID,
DrvEEID              = DrvEEID,
DrvDepID             = DbnDepRecID,
drvTransDate         = drvTransDate,
drvGroupID           = drvGroupID,
drvRelationship      = case 
                       when conrelationship in ('DP','SPS') and congender = 'F' then 'W'
                       when conrelationship in ('DP','SPS') and congender = 'M' then 'H'
                       when conrelationship in ('CHL','STC') and congender = 'F' then 'D'
                       when conrelationship in ('CHL','STC') and congender = 'M' then 'S'
                       ELSE ''
                       end ,
drvSubscriberID      = drvSubscriberID,
drvNameLast          = ltrim(rtrim(ConNameLast)),
drvNameFirst         = ltrim(rtrim(ConNameFirst)),
drvNameMiddle        = LEFT(ConNameMiddle, 1),
drvGender            = ConGender,
drvDateOfBirth       = CONVERT(CHAR(8), ConDateOfBirth, 112),
drvMaritalStatus     = '', --case when conrelationship = 'SPS' then 'M' else 'S' end,
drvEmpID             = drvEmpID,
drvAddressLine1      = dbo.dsi_fnRemoveChars('.,/-#*&', ConAddressLine1),
drvAddressLine2      = dbo.dsi_fnRemoveChars('.,/-#*&', ConAddressLine2),
drvAddress3          = '',
drvAddressCity       = ConAddressCity,
drvAddressState      = ConAddressState,
drvZIP               = ConAddressZipCode,
drvCountry           = '',
drvHomePhone         = '',--ConPhoneHomeNumber,
drvWorkPhone         = '',--drvWorkPhone,
drvWorkExt           = '',
drvDateOfHire        = drvDateOfHire,
drvEffDate           = drvEffDate,
                       --CASE 
                       --WHEN DbnBenStartDate < @PlanDate THEN CONVERT(CHAR(8), @PlanDate, 112)
                       --ELSE CONVERT(VARCHAR(8), DbnBenStartDate, 112) 
                       --END,
drvMemberSSN         = '', --ConSSN,
drvFullTimeStudent   = '',
drvRelationshipDate  = drvRelationshipDate,
                      --CASE 
                      --WHEN DbnBenStartDate < @PlanDate THEN CONVERT(CHAR(8), @PlanDate, 112)
                      --ELSE CONVERT(VARCHAR(8), DbnBenStartDate, 112) 
                      --END,
drvSubgroupID        = drvSubgroupID,
drvEmpDataSegDate  = '' , -- = '5/18/1972',
drvOccupation        = '',
drvDept              = '',
drvLocID = '', --            = '',
drvLocDesc = ''  , --        = '',
drvDateofLastHire    = drvDateofLastHire,
drvSalEffDate        = CONVERT(CHAR(8), ''), -- updated below
drvSalMode           = '',
drvSalAmt            = '',
drvClassEffDate      = '',
drvClassID           = '',
drvRateEffDate       = '',
drvSmoker            = '',

-- Dental

drvDentalLateEntrant = '',
drvDentProdCatD      = CASE WHEN dental.BdmDedCode IS NOT NULL THEN 'D' ELSE '' END,
drvDentEffDateD      = CASE
                          WHEN dental.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), dental.BdmBenStopDate + 1, 112)
                          WHEN dental.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN dental.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), dental.BdmBenStartDate, 112)
                          ELSE ''
                       END,
drvDentEligEventD    = 
                       CASE
                          WHEN dental.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN dental.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END ,
drvDentPlanIDD       = Case 
                       WHEN dental.BdmDedCode IS NOT NULL then CASE WHEN EepAddressState = 'TX' THEN 'WTP0001300' ELSE 'WTP0004900' END  --WTP0004900/WTP0001300 
                       END ,
drvDentFamCovD       = CASE WHEN dental.BdmDedCode IS NOT NULL THEN 
                            CASE WHEN dental.BdmBenOption ='EE' THEN 'C'
                                 WHEN dental.BdmBenOption = 'EE1D' AND  dental.BdmNumSpouses <> 0 AND dental.BdmNumChildren = 0 THEN 'B'    
                                 WHEN dental.BdmBenOption = 'EE1D' AND  dental.BdmNumSpouses = 0 AND dental.BdmNumChildren <> 0 THEN 'D'
                                 WHEN dental.BdmBenOption =  'EE2D' THEN 'A'
                                 WHEN dental.BdmBenOption =  'EEC' THEN 'D'
                                 WHEN dental.BdmBenOption =  'EES' THEN 'B'
                                 ELSE 'A' END
                                 ELSE '' END ,


/*
drvDentalLateEntrant = '',
drvDentProdCatD      =  CAST(CASE WHEN dental.BdmDedCode IS NOT NULL THEN 'D' ELSE '' END  AS VARCHAR (50)),
drvDentEffDateD      =  CAST(CASE
                          WHEN dental.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), dental.BdmBenStopDate + 1, 112)
                          WHEN dental.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN dental.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), dental.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvDentEligEventD    = CAST(CASE
                          WHEN dental.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN dental.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvDentPlanIDD       = CAST(Case 
                       WHEN dental.BdmDedCode IS NOT NULL then CASE WHEN EepAddressState = 'TX' THEN 'WTP0001300' ELSE 'WTP0004900' END  --WTP0004900/WTP0001300 
                       END  AS VARCHAR (50)),
drvDentFamCovD       = CAST(CASE WHEN dental.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END  AS VARCHAR (50)),
*/
-- 1: Basic life

drvProdCat1          = CASE WHEN basiclife.BdmDedCode IS NOT NULL THEN '1' ELSE '' END,
drvEffDate1          = CASE
                          WHEN basiclife.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), basiclife.BdmBenStopDate + 1, 112)
                          WHEN basiclife.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN basiclife.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), basiclife.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEvent1        = CASE
                          WHEN basiclife.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN basiclife.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,     
drvPlanID1           = Case 
                       when basiclife.BdmDedCode = 'GLIFE' then 'LTL00NCSAL'
                       When basiclife.BdmDedCode = 'GLIF5' then 'LTL0NCFLAT'
                       end,
drvFamCov1           = CASE WHEN basiclife.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,

-- a: Basic AD&D

drvProdCata          = CASE WHEN basicADD.BdmDedCode IS NOT NULL THEN '1' ELSE '' END,
drvEffDatea          = CASE
                          WHEN basicADD.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), basicADD.BdmBenStopDate + 1, 112)
                          WHEN basicADD.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN basicADD.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), basicADD.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEventa        = CASE
                          WHEN basicADD.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN basicADD.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,     
drvPlanIDa           = CASE 
                            WHEN basicADD.BdmDedCode = 'ADD50' THEN 'ATA0NCFLAT'
                            WHEN basicADD.BdmDedCode = 'ADD2X' THEN 'ATA00NCSAL'
                            ELSE '' 
                       END,
drvFamCova           = CASE WHEN basicADD.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,

-- S: Unused

drvProdCatS          = '',
drvEffDateS          = '',
drvEligEventS        = '',
drvPlanIDS           = '',
drvFamCovS           = '',

-- T: Basic LTD

drvProdCatT          = CASE WHEN basicLTD.BdmDedCode IS NOT NULL THEN 'T' ELSE '' END,
drvEffDateT          = CASE
                          WHEN basicLTD.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), basicLTD.BdmBenStopDate + 1, 112)
                          WHEN basicLTD.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN basicLTD.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), basicLTD.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEventT        = CASE
                          WHEN basicLTD.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN basicLTD.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,     
drvPlanIDT           = CASE WHEN basicLTD.BdmDedCode IS NOT NULL THEN 'TTT00NCSAL' ELSE '' END,
drvFamCovT           = CASE WHEN basicLTD.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,
drvNomEffDateT       = '',
drvNomAmtT           = '',

-- 3: Voluntary Term Life Coverage Member

drvProdCat3          = CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN '3' ELSE '' END,
drvEffDate3          = CASE
                          WHEN supplEE.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), supplEE.BdmBenStopDate + 1, 112)
                          WHEN supplEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplEE.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEvent3        = CASE
                          WHEN supplEE.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN supplEE.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,     
drvPlanID3           = CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN 'ETL0CEEVAL' ELSE '' END,
drvFamCov3           = CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,
drvNomEffDate3       = CASE
                          WHEN supplEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplEE.BdmBenStartDate, 112)
                          ELSE ''
                       END,
drvNomAmt3           = CASE WHEN supplEE.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplEE.BdmEEAmt, 10, 0) ELSE '' END,

-- 4: Voluntary Term Life Coverage Spouse

drvProdCat4          = CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN '4' ELSE '' END,
drvEffDate4          = CASE
                          WHEN supplSP.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), supplSP.BdmBenStopDate + 1, 112)
                          WHEN supplSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplSP.BdmBenStartDate, 112)
                          ELSE ''
                       END,  
drvEligEvent4        = CASE
                          WHEN supplSP.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN supplSP.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END, 
drvPlanID4           = CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN 'ETL0CSPVAL' ELSE '' END,
drvFamCov4           = CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,
drvNomEffDate4       = 
CASE
                          WHEN supplSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplSP.BdmBenStartDate, 112)
                          ELSE ''
                       END,
drvNomAmt4           = --CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplSP.BdmEEAmt, 10, 0) ELSE '' END,
                       CASE WHEN supplSP.BdmDedCode IS NOT NULL THEN drvNomAmt4   ELSE '' END, -- Pull from employee's amount

-- 5: Voluntary Term Life Coverage Child

drvProdCat5          = CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN '5' ELSE '' END,
drvEffDate5          = CASE
                          WHEN supplCH.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), supplCH.BdmBenStopDate + 1, 112)
                          WHEN supplCH.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplCH.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplCH.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEvent5        = CASE
                          WHEN supplCH.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN supplCH.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,     
drvPlanID5           = CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN 'ETL0CDPVAL' ELSE '' END,
drvFamCov5           = CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,
drvNomEffDate5       = CASE
                          WHEN supplCH.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN supplCH.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), supplCH.BdmBenStartDate, 112)
                          ELSE ''
                       END,
drvNomAmt5           = --CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplCH.BdmEEAmt, 10, 0) ELSE '' END,
                        CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN drvNomAmt5 ELSE '' END, -- Pull from employee's amount
 --CASE WHEN supplCH.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(supplCH.BdmEEAmt, 10, 0) ELSE '' END,

-- c: unused

drvProdCatc          = '',
drvEffDatec          = '',
drvEligEventc        = '',
drvPlanIDc           = '',
drvFamCovc           = '',
drvNomEffDatec       = '',
drvNomAmtc           = '',

-- e: unused

drvProdCate          = '',
drvEffDatee          = '',
drvEligEvente        = '',
drvPlanIDe           = '',
drvFamCove           = '',
drvNomEffDatee       = '',
drvNomAmte           = '',

-- d: unused

drvProdCatd          = '',
drvEffDated          = '',
drvEligEventd        = '',
drvPlanIDd           = '',
drvFamCovd           = '',
drvNomEffDated       = '',
drvNomAmtd           = '',

-- Q: STD

drvProdCatQ          = CASE WHEN std.BdmDedCode IS NOT NULL THEN 'Q' ELSE '' END,
drvEffDateQ          = CASE
                          WHEN std.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), std.BdmBenStopDate + 1, 112)
                          WHEN std.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN std.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), std.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEventQ        = CASE
                          WHEN std.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN std.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,     
drvPlanIDQ           = CASE WHEN std.BdmDedCode IS NOT NULL THEN 'YTS0PCVABS' ELSE '' END,
drvFamCovQ           = CASE WHEN std.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,
drvPriorSTDCovL      = '',--CASE WHEN std.BdmDedCode IS NOT NULL THEN 'N' ELSE '' END, 

-- L: LTD

drvProdCatL          = CASE WHEN ltd.BdmDedCode IS NOT NULL THEN 'L' ELSE '' END,
drvEffDateL          = CASE
                          WHEN ltd.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), ltd.BdmBenStopDate + 1, 112)
                          WHEN ltd.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN ltd.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), ltd.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEventL        = CASE
                          WHEN ltd.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN ltd.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,  
drvPlanIDL           = CASE WHEN ltd.BdmDedCode = 'LTD1' THEN 'ZTT0CABSAL'
                            WHEN ltd.BdmDedCode = 'LTD2' THEN 'ZTT000CSAL' 
                            ELSE '' END,
drvFamCovL           = CASE WHEN ltd.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,


 -- R: Voluntary STD Buy-Up Contrib ***** class A004/A009*********

drvProdCatR          = CAST(CASE WHEN vstd.BdmDedCode IS NOT NULL AND vw_int_EmpComp.EecJobCode IN ('ADMIN', 'CLER', 'NMGR', 'TAX', 'RECR' ) THEN 'R' ELSE '' END  AS VARCHAR (50)),
drvEffDateR          =CAST( CASE
                          WHEN vstd.BdmBenStopDate IS NOT NULL AND vw_int_EmpComp.EecJobCode IN ('ADMIN', 'CLER', 'NMGR', 'TAX', 'RECR')   THEN CONVERT(VARCHAR(8), vstd.BdmBenStopDate + 1, 112)
                          WHEN vstd.BdmBenStartDate < @PlanDate AND vw_int_EmpComp.EecJobCode IN ('ADMIN', 'CLER', 'NMGR', 'TAX', 'RECR') THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN vstd.BdmBenStartDate IS NOT NULL AND vw_int_EmpComp.EecJobCode IN ('ADMIN', 'CLER', 'NMGR', 'TAX', 'RECR') THEN CONVERT(VARCHAR(8), vstd.BdmBenStartDate, 112)
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvEligEventR        = CAST(CASE
                          WHEN vstd.BdmBenStopDate IS NOT NULL AND vw_int_EmpComp.EecJobCode IN ('ADMIN', 'CLER', 'NMGR', 'TAX', 'RECR') THEN 'TM'
                          WHEN vstd.BdmDedCode IS NOT NULL AND vw_int_EmpComp.EecJobCode IN ('ADMIN', 'CLER', 'NMGR', 'TAX', 'RECR')    THEN 'EN'
                          ELSE ''
                       END  AS VARCHAR (50)),     
drvPlanIDR           = CAST(CASE WHEN vstd.BdmDedCode IS NOT NULL AND vw_int_EmpComp.EecJobCode IN ('ADMIN', 'CLER', 'NMGR', 'TAX', 'RECR') THEN 'JTS00CFLAT' ELSE '' END  AS VARCHAR (50)),
drvFamCovR           = CAST(CASE WHEN vstd.BdmDedCode IS NOT NULL AND vw_int_EmpComp.EecJobCode IN ('ADMIN', 'CLER', 'NMGR', 'TAX', 'RECR') THEN 'C' ELSE '' END  AS VARCHAR (50)),



-- A: Voluntary Employee/Children Critical Illness

drvProdCatAA         = CASE WHEN illnessEE.BdmDedCode IS NOT NULL THEN 'A' ELSE '' END,
drvEffDateAA         = CASE
                          WHEN illnessEE.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), illnessEE.BdmBenStopDate + 1, 112)
                          WHEN illnessEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN illnessEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), illnessEE.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEventAA       = CASE
                          WHEN illnessEE.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN illnessEE.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,     
drvPlanIDAA          = CASE WHEN illnessEE.BdmDedCode IS NOT NULL THEN '3CI00EDVAB' ELSE '' END,
drvFamCovAA          = CASE WHEN illnessEE.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,
drvNomEffDateAA      = CASE
                          WHEN illnessEE.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN illnessEE.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), illnessEE.BdmBenStartDate, 112)
                          ELSE ''
                       END,
drvNomAmtAA          = CASE WHEN illnessEE.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(illnessEE.BdmEEAmt, 10, 0) ELSE '' END,    


-- J:Voluntary Spouse Critical Illness

drvProdCatJ          = CASE WHEN illnessSP.BdmDedCode IS NOT NULL THEN 'J' ELSE '' END,
drvEffDateJ          = CASE
                          WHEN illnessSP.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), illnessSP.BdmBenStopDate + 1, 112)
                          WHEN illnessSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN illnessSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), illnessSP.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEventJ        = CASE
                          WHEN illnessSP.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN illnessSP.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,     
drvPlanIDJ           = CASE WHEN illnessSP.BdmDedCode IS NOT NULL THEN '3CI00SPVAB' ELSE '' END,
drvFamCovJ           = CASE WHEN illnessSP.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,
drvNomEffDateJ       = CASE
                          WHEN illnessSP.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN illnessSP.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), illnessSP.BdmBenStartDate, 112)
                          ELSE ''
                       END,
drvNomAmtJ           = CASE WHEN illnessSP.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(illnessSP.BdmEEAmt, 10, 0) ELSE '' END,    

 
-- J:Voluntary Accident

drvProdCatg          = CASE WHEN accident.BdmDedCode IS NOT NULL THEN 'g' ELSE '' END,
drvEffDateg         = CASE
                          WHEN accident.BdmBenStopDate IS NOT NULL   THEN CONVERT(VARCHAR(8), accident.BdmBenStopDate + 1, 112)
                          WHEN accident.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN accident.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), accident.BdmBenStartDate, 112)
                          ELSE ''
                       END,     
drvEligEventg        = CASE
                          WHEN accident.BdmBenStopDate IS NOT NULL THEN 'TM'
                          WHEN accident.BdmDedCode IS NOT NULL     THEN 'EN'
                          ELSE ''
                       END,     
drvPlanIDg           = CASE WHEN accident.BdmDedCode IS NOT NULL THEN '6AS000VACC' ELSE '' END,
drvFamCovg           = --CASE WHEN accident.BdmDedCode IS NOT NULL THEN 'C' ELSE '' END,
                    CAST(CASE WHEN accident.BdmDedCode IS NOT NULL THEN CASE
                       WHEN accident.BdmBenOption in ('EEF') then 'A'
                       WHEN accident.BdmBenOption in ('EES') then 'B'
                       WHEN accident.BdmBenOption in ('EE') then 'C'
                       WHEN accident.BdmBenOption in ('EEC') then 'D'
                       WHEN accident.BdmBenOption in ('EE1D') AND  accident.BdmNumSpouses <> 0 AND accident.BdmNumChildren = 0  then 'B'
                       WHEN accident.BdmBenOption in ('EE1D') AND  accident.BdmNumSpouses = 0 AND accident.BdmNumChildren <> 0  then 'D'
                       WHEN accident.BdmBenOption in ('EE2D') then 'A'
                       Else 'A' End    
                       ELSE '' END  AS VARCHAR (50)),
drvNomEffDateg       = CASE
                          WHEN accident.BdmBenStartDate < @PlanDate  THEN CONVERT(VARCHAR(8), @PlanDate, 112)
                          WHEN accident.BdmBenStartDate IS NOT NULL  THEN CONVERT(VARCHAR(8), accident.BdmBenStartDate, 112)
                          ELSE ''
                       END,
drvNomAmtg          = CASE WHEN accident.BdmDedCode IS NOT NULL THEN dbo.dsi_fnPadZero(accident.BdmEEAmt, 10, 0) ELSE '' END

--select *
FROM --dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Master WITH (NOLOCK)
dbo.U_dsi_bdm_DepDeductions
    join dbo.U_Dsi_DrvTbl_EMUTOMHTR2 on dbneeid = drveeid and drvdepid IS NULL
JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = DbnEEID
JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON EecEEID = DbnEEID
join contacts on coneeid = dbneeid and consystemid = dbndeprecid
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage dental    WITH (NOLOCK) ON dental.BdmDedCode in ('XXXX')     AND dental.BdmEEID = DbnEEID    AND dental.BdmCOID = drvCOID and Dental.BDMRelationship = conRelationship
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage basiclife WITH (NOLOCK) ON basiclife.BdmDedCode in ('XXXX')  AND basiclife.BdmEEID = DbnEEID AND basiclife.BdmCOID = drvCOID        
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage basicADD  WITH (NOLOCK) ON basicADD.BdmDedCode in ('XXXXX')  AND basicADD.BdmEEID = DbnEEID  AND basicADD.BdmCOID = drvCOID         
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage basicLTD  WITH (NOLOCK) ON basicLTD.BdmDedCode IN ('XXXXX')  AND basicLTD.BdmEEID = DbnEEID  AND basicLTD.BdmCOID = drvCOID         
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage supplEE   WITH (NOLOCK) ON supplEE.BdmDedCode = 'LIFEE'      AND supplEE.BdmEEID = DbnEEID   AND supplEE.BdmCOID = drvCOID          

LEFT JOIN (select ROW_NUMBER() over(Partition by BdmCOID, BdmEEID,BdmDedCode,BdmRelationship  order by convert(datetime,BdmBenStartDate)desc) RowNum,BdmBenStartDate,BdmBenStopDate,BdmCOID,BdmDedCode,BdmRelationship,BdmEEAmt,BdmEEID
FROM U_Dsi_DrvTbl_EMUTOMHTR2_Coverage) supplSP ON supplSP.BdmDedCode = 'LIFES' AND supplSP.ROWNUM = 1 AND supplSP.BdmEEID = DbnEEID   AND supplSP.BdmCOID = drvCOID and supplSP.BdmRelationship = 'SPS'         

LEFT JOIN (select ROW_NUMBER() over(Partition by BdmCOID, BdmEEID,BdmDedCode,BdmRelationship  order by convert(datetime,BdmBenStartDate)desc) RowNum,BdmBenStartDate,BdmBenStopDate,BdmCOID,BdmDedCode,BdmRelationship,BdmEEAmt,BdmEEID
FROM U_Dsi_DrvTbl_EMUTOMHTR2_Coverage) supplCH ON supplCH.BdmDedCode = 'LIFEC' AND supplCH.ROWNUM = 1 AND supplCH.BdmEEID = DbnEEID   AND supplCH.BdmCOID = drvCOID  and supplCH.BdmRelationship = 'CHL'          

LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage std       WITH (NOLOCK) ON std.BdmDedCode IN ('')--('STD', 'STD1', 'STD2', 'STD3', 'STD4', 'STD5', 'STD6', 'STDV')  
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage vstd      WITH (NOLOCK) ON vstd.BdmDedCode IN ('')--STD
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage ltd       WITH (NOLOCK) ON ltd.BdmDedCode IN ('XXXX')                       AND ltd.BdmEEID = DbnEEID       AND ltd.BdmCOID = drvCOID              
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage illnessEE WITH (NOLOCK) ON illnessEE.BdmDedCode in ('')   --CIENT      AND illnessEE.BdmEEID = DbnEEID AND illnessEE.BdmCOID = drvCOID -- and illnessEE.bdmeeamt is not null 
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage illnessSP WITH (NOLOCK) ON illnessSP.BdmDedCode in ('XXXX')         AND illnessSP.BdmEEID = DbnEEID AND illnessSP.BdmCOID = drvCOID--  and illnessSP.bdmeeamt is not null
LEFT JOIN dbo.U_Dsi_DrvTbl_EMUTOMHTR2_Coverage accident WITH (NOLOCK) ON accident.BdmDedCode in ('XXXX')                AND accident.BdmEEID = DbnEEID AND accident.BdmCOID = drvCOID   and accident.BdmRelationship = conRelationship
/*LEFT JOIN dbo.U_EMUTOMHTR2_Audit WITH (NOLOCK)
    ON MstEEID = audEEID
    AND MstCOID = audKey2*/


where DbnFormatCode = @FormatCode and dbnvalidforexport = 'Y' 
AND ConRelationship IN ('DP','SPS') -- Only include spouse records
;

-----------------------
-- Update salary effective date
-----------------------

WITH TempSelectTable AS (

   SELECT

   EjhEEID            TmpEEID,
   MAX(EjhJobEffDate) TmpJobEffDate

   FROM vw_int_EmpHJob
   JOIN U_Dsi_DrvTbl_EMUTOMHTR2 WITH (NOLOCK) ON DrvCOID = EjhCOID AND DrvEEID = EjhEEID
   WHERE EjhIsRateChange = 'Y'
   GROUP BY EjhEEID
)
UPDATE U_Dsi_DrvTbl_EMUTOMHTR2
   SET drvSalEffDate = 
                       CASE 
                          WHEN isnull(TmpJobEffDate,eecdateinjob) < @PlanDate THEN CONVERT(CHAR(8), @PlanDate, 112)
                          ELSE CONVERT(VARCHAR(10), isnull(TmpJobEffDate,eecdateinjob), 112)
                       END
  FROM U_Dsi_DrvTbl_EMUTOMHTR2
  left join TempSelectTable on DrvEEID = TmpEEID
     AND TmpJobEffDate IS NOT NULL
     AND TmpJobEffDate > drvDateofLastHire
  join vw_int_EmpComp with (nolock) on eeccoid = drvcoid and eeceeid = drveeid
  where drvdepid is null 

----------
-- Set filename
-----------

--IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N') BEGIN
--   UPDATE dbo.U_dsi_Parameters
--      SET ExportFile =  @FormatCode + '_' + CONVERT(CHAR(8) ,GETDATE(), 112) + '.txt'
--    WHERE FormatCode = @FormatCode
--END

END
GO
CREATE  View dbo.dsi_vwEMUTOMHTR2_Export as
        select top 2000000 left(data,(len(data))) as data from dbo.U_EMUTOMHTR2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'D' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)