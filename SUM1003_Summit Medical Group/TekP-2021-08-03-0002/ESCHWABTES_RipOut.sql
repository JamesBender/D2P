SET NOCOUNT ON;
IF OBJECT_ID('U_ESCHWABTES_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESCHWABTES_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESCHWABTES_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESCHWABTES' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESCHWABTES_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESCHWABTES_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESCHWABTES') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESCHWABTES];
GO
IF OBJECT_ID('U_ESCHWABTES_File') IS NOT NULL DROP TABLE [dbo].[U_ESCHWABTES_File];
GO
IF OBJECT_ID('U_ESCHWABTES_EEList_401k') IS NOT NULL DROP TABLE [dbo].[U_ESCHWABTES_EEList_401k];
GO
IF OBJECT_ID('U_ESCHWABTES_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESCHWABTES_EEList];
GO
IF OBJECT_ID('U_dsi_ESCHWABTES_YTDearnamts') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWABTES_YTDearnamts];
GO
IF OBJECT_ID('U_dsi_ESCHWABTES_YTDdedamts') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWABTES_YTDdedamts];
GO
IF OBJECT_ID('U_dsi_ESCHWABTES_drvtrl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWABTES_drvtrl];
GO
IF OBJECT_ID('U_dsi_ESCHWABTES_drvtbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWABTES_drvtbl];
GO
IF OBJECT_ID('U_dsi_ESCHWABTES_curearnamts') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWABTES_curearnamts];
GO
IF OBJECT_ID('U_dsi_ESCHWABTES_curdedamts') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESCHWABTES_curdedamts];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESCHWABTES';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESCHWABTES';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESCHWABTES';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESCHWABTES';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESCHWABTES';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ESCHWABTES','Schwab 401K export TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_SwitchBox_v2','545','S','N','7X1T7L0010T0','N',NULL,'C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RID"','1','(''DA''=''F'')','7X1T7L0010T0','3','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PlanID "','2','(''DA''=''F'')','7X1T7L0010T0','6','H','01','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','3','(''DA''=''F'')','7X1T7L0010T0','11','H','01','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name                     "','4','(''DA''=''F'')','7X1T7L0010T0','20','H','01','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name                    "','5','(''DA''=''F'')','7X1T7L0010T0','15','H','01','41',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"M "','6','(''DA''=''F'')','7X1T7L0010T0','1','H','01','56',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"401KREG         "','7','(''DA''=''F'')','7X1T7L0010T0','11','H','01','57',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CATCHUP         "','8','(''DA''=''F'')','7X1T7L0010T0','11','H','01','68',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MATCH         "','9','(''DA''=''F'')','7X1T7L0010T0','11','H','01','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PROFITSHARE         "','10','(''DA''=''F'')','7X1T7L0010T0','11','H','01','90',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"401KROTH         "','11','(''DA''=''F'')','7X1T7L0010T0','11','H','01','101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SAFEHARBOR         "','12','(''DA''=''F'')','7X1T7L0010T0','11','H','01','112',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan               "','13','(''DA''=''F'')','7X1T7L0010T0','11','H','01','123',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Loan2               "','14','(''DA''=''F'')','7X1T7L0010T0','11','H','01','134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PerTotComp"','15','(''DA''=''F'')','7X1T7L0010T0','11','H','01','145',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PerHrsWork       "','16','(''DA''=''F'')','7X1T7L0010T0','4','H','01','156',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTD401K"','17','(''DA''=''F'')','7X1T7L0010T0','11','H','01','160',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTDCATCH"','18','(''DA''=''F'')','7X1T7L0010T0','11','H','01','171',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTDMATCH"','19','(''DA''=''F'')','7X1T7L0010T0','11','H','01','182',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTDPS"','20','(''DA''=''F'')','7X1T7L0010T0','11','H','01','193',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTDROTH"','21','(''DA''=''F'')','7X1T7L0010T0','11','H','01','204',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTDSH"','22','(''DA''=''F'')','7X1T7L0010T0','11','H','01','215',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"YTDTotComp"','23','(''DA''=''F'')','7X1T7L0010T0','11','H','01','226',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HWrk         "','24','(''DA''=''F'')','7X1T7L0010T0','4','H','01','237',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"F"','25','(''DA''=''F'')','7X1T7L0010T0','1','H','01','241',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A "','26','(''DA''=''F'')','7X1T7L0010T0','1','H','01','242',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Address Line #1                 "','27','(''DA''=''F'')','7X1T7L0010T0','30','H','01','243',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Address Line #2                 "','28','(''DA''=''F'')','7X1T7L0010T0','30','H','01','273',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary City "','29','(''DA''=''F'')','7X1T7L0010T0','30','H','01','303',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"St "','30','(''DA''=''F'')','7X1T7L0010T0','2','H','01','333',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code "','31','(''DA''=''F'')','7X1T7L0010T0','10','H','01','335',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Country "','32','(''DA''=''F'')','7X1T7L0010T0','30','H','01','345',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','33','(''DA''=''F'')','7X1T7L0010T0','8','H','01','375',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HireDate "','34','(''DA''=''F'')','7X1T7L0010T0','8','H','01','383',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PlanDate "','35','(''DA''=''F'')','7X1T7L0010T0','8','H','01','391',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TermDate "','36','(''DA''=''F'')','7X1T7L0010T0','8','H','01','399',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RehireDt"','37','(''DA''=''F'')','7X1T7L0010T0','8','H','01','407',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PT% "','38','(''DA''=''F'')','7X1T7L0010T0','3','H','01','415',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"S"','39','(''DA''=''F'')','7X1T7L0010T0','1','H','01','418',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rpt Division                      "','40','(''DA''=''F'')','7X1T7L0010T0','15','H','01','419',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Alt Key #1 "','41','(''DA''=''F'')','7X1T7L0010T0','15','H','01','434',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Alt Key #2"','42','(''DA''=''F'')','7X1T7L0010T0','15','H','01','449',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone "','43','(''DA''=''F'')','7X1T7L0010T0','12','H','01','464',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Status Reason"','44','(''DA''=''F'')','7X1T7L0010T0','1','H','01','476',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','45','(''DA''=''F'')','7X1T7L0010T0','50','H','01','477',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Transfer Indicator"','46','(''DA''=''F'')','7X1T7L0010T0','18','H','01','527',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"100"','1','(''DA''=''F'')','7X1T7L0010T0','3','D','02','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SMT"','2','(''DA''=''F'')','7X1T7L0010T0','6','D','02','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''F'')','7X1T7L0010T0','11','D','02','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','4','(''UA''=''F'')','7X1T7L0010T0','20','D','02','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''F'')','7X1T7L0010T0','15','D','02','41',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddlename"','6','(''UA''=''F'')','7X1T7L0010T0','1','D','02','56',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv401KREG"','7','(''UA''=''F'')','7X1T7L0010T0','11','D','02','57',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','7X1T7L0010T0','11','D','02','68',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMATCH"','9','(''UA''=''F'')','7X1T7L0010T0','11','D','02','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPROFITSHARE"','10','(''UA''=''F'')','7X1T7L0010T0','11','D','02','90',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drv401KROTH"','11','(''UA''=''F'')','7X1T7L0010T0','11','D','02','101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSAFEHARBOR"','12','(''UA''=''F'')','7X1T7L0010T0','11','D','02','112',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoan"','13','(''UA''=''F'')','7X1T7L0010T0','11','D','02','123',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000000000"','14','(''DA''=''F'')','7X1T7L0010T0','11','D','02','134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPerTotComp"','15','(''UA''=''F'')','7X1T7L0010T0','11','D','02','145',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPerHrsWork"','16','(''UA''=''F'')','7X1T7L0010T0','4','D','02','156',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTD401K"','17','(''UA''=''F'')','7X1T7L0010T0','11','D','02','160',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','7X1T7L0010T0','11','D','02','171',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDMATCH"','19','(''UA''=''F'')','7X1T7L0010T0','11','D','02','182',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPS"','20','(''UA''=''F'')','7X1T7L0010T0','11','D','02','193',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDROTH"','21','(''UA''=''F'')','7X1T7L0010T0','11','D','02','204',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDSH"','22','(''UA''=''F'')','7X1T7L0010T0','11','D','02','215',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotComp"','23','(''UA''=''F'')','7X1T7L0010T0','11','D','02','226',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDHrsWork"','24','(''UA''=''F'')','7X1T7L0010T0','4','D','02','237',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFreq"','25','(''UA''=''F'')','7X1T7L0010T0','1','D','02','241',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','26','(''DA''=''F'')','7X1T7L0010T0','1','D','02','242',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','27','(''UA''=''F'')','7X1T7L0010T0','30','D','02','243',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','28','(''UA''=''F'')','7X1T7L0010T0','30','D','02','273',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','29','(''UA''=''F'')','7X1T7L0010T0','30','D','02','303',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','30','(''UA''=''F'')','7X1T7L0010T0','2','D','02','333',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','31','(''UA''=''F'')','7X1T7L0010T0','10','D','02','335',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','32','(''UA''=''F'')','7X1T7L0010T0','30','D','02','345',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','33','(''UA''=''F'')','7X1T7L0010T0','8','D','02','375',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','34','(''UA''=''F'')','7X1T7L0010T0','8','D','02','383',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanDate"','35','(''UA''=''F'')','7X1T7L0010T0','8','D','02','391',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','36','(''UA''=''F'')','7X1T7L0010T0','8','D','02','399',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDt"','37','(''UA''=''F'')','7X1T7L0010T0','8','D','02','407',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''F'')','7X1T7L0010T0','3','D','02','415',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','39','(''UA''=''F'')','7X1T7L0010T0','1','D','02','418',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRptDivision"','40','(''UA''=''F'')','7X1T7L0010T0','15','D','02','419',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAltKey1"','41','(''UA''=''F'')','7X1T7L0010T0','15','D','02','434',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAltKey2"','42','(''UA''=''F'')','7X1T7L0010T0','15','D','02','449',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','43','(''UA''=''F'')','7X1T7L0010T0','12','D','02','464',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvBenefitStatusReason','44','(''UA''=''F'')','7X1T7L0010T0','1','D','02','476',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEmailAddress','45','(''UA''=''F'')','7X1T7L0010T0','50','D','02','477',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvTransferIndicator','46','(''UA''=''F'')','7X1T7L0010T0','1','D','02','527',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"100"','1','(''DA''=''F'')','7X1T7L0010T0','3','T','03','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SMT"','2','(''DA''=''F'')','7X1T7L0010T0','6','T','03','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvpedate"','3','(''UA''=''F'')','7X1T7L0010T0','8','T','03','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''SS''=''F'')','7X1T7L0010T0','39','T','03','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvsource1tot"','5','(''UA''=''F'')','7X1T7L0010T0','11','T','03','57',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000000000"','6','(''DA''=''F'')','7X1T7L0010T0','11','T','03','68',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvsource3tot"','7','(''UA''=''F'')','7X1T7L0010T0','11','T','03','79',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvsource4tot"','8','(''UA''=''F'')','7X1T7L0010T0','11','T','03','90',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvsource5tot"','9','(''UA''=''F'')','7X1T7L0010T0','11','T','03','101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvsource6tot"','10','(''UA''=''F'')','7X1T7L0010T0','11','T','03','112',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvloan1tot"','11','(''UA''=''F'')','7X1T7L0010T0','11','T','03','123',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00000000000"','12','(''DA''=''F'')','7X1T7L0010T0','11','T','03','134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('20211015 Schwab Semimonthly',NULL,NULL,NULL,'UFMUO',NULL,NULL,NULL,'Schwab 401K export','202110159','EMPEXPORT','ESCHWABTES','Oct 15 2021  9:00AM','ESCHWABTES',NULL,NULL,NULL,'202110159','Oct 15 2021 12:00AM','Dec 30 1899 12:00AM','202110151','167','eecPayGroup','SFT,SPAR,SPRN,SPT','202110151',dbo.fn_GetTimedKey(),NULL,'CALLEY',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('TEST_20141121 Schwab Biweekly',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testing Purposes Only','201411219','EMPEXPORT','TEST','Nov 19 2014 10:48AM','ESCHWABTES',NULL,NULL,NULL,'201411219','Nov 21 2014 12:00AM','Dec 30 1899 12:00AM','201411211','1861','','','201411211',dbo.fn_GetTimedKey(),NULL,'CALLEY',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWABTES','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWABTES','ExportPath','V','\\US.SAAS\e2\Public\10752\Exports\CharlesSchwab\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWABTES','InitialSort','C','drvssn');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWABTES','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWABTES','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWABTES','TestPath','V','\\US.SAAS\e2\Public\10752\Exports\CharlesSchwab\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESCHWABTES','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_ESCHWABTES_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_ESCHWABTES_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESCHWABTES_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESCHWABTES','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESCHWABTES','D02','dbo.U_dsi_ESCHWABTES_drvtbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESCHWABTES','T03','dbo.U_dsi_ESCHWABTES_drvtrl',NULL);
IF OBJECT_ID('U_dsi_ESCHWABTES_curdedamts') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWABTES_curdedamts] (
    [pdheeid] char(12) NOT NULL,
    [pdhcoid] char(5) NOT NULL,
    [dedcode] varchar(7) NULL,
    [eecuramt] money NULL,
    [ercuramt] money NULL
);
IF OBJECT_ID('U_dsi_ESCHWABTES_curearnamts') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWABTES_curearnamts] (
    [peheeid] char(12) NOT NULL,
    [pehcoid] char(5) NOT NULL,
    [eecurhrs] decimal NULL,
    [eecuramt] money NULL
);
IF OBJECT_ID('U_dsi_ESCHWABTES_drvtbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWABTES_drvtbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvssn] char(11) NULL,
    [drvlastname] varchar(100) NULL,
    [drvfirstname] varchar(100) NULL,
    [drvmiddlename] varchar(1) NULL,
    [drv401KREGamt] money NULL,
    [drv401KREG] varchar(11) NOT NULL,
    [drvMATCHamt] money NULL,
    [drvMATCH] varchar(11) NOT NULL,
    [drvPROFITSHAREamt] money NULL,
    [drvPROFITSHARE] varchar(11) NOT NULL,
    [drv401KROTHamt] money NULL,
    [drv401KROTH] varchar(11) NOT NULL,
    [drvSAFEHARBORamt] money NULL,
    [drvSAFEHARBOR] varchar(11) NOT NULL,
    [drvloanamt] money NULL,
    [drvloan] varchar(11) NOT NULL,
    [drvPerTotCompamt] money NULL,
    [drvPerTotComp] varchar(11) NOT NULL,
    [drvPerHrsWorkamt] int NULL,
    [drvPerHrsWork] varchar(4) NOT NULL,
    [drvYTD401Kamt] money NULL,
    [drvYTD401K] varchar(11) NOT NULL,
    [drvYTDMATCHamt] money NULL,
    [drvYTDMATCH] varchar(11) NOT NULL,
    [drvYTDPSamt] money NULL,
    [drvYTDPS] varchar(11) NOT NULL,
    [drvYTDROTHamt] money NULL,
    [drvYTDROTH] varchar(11) NOT NULL,
    [drvYTDSHamt] money NULL,
    [drvYTDSH] varchar(11) NOT NULL,
    [drvYTDTotCompamt] money NULL,
    [drvYTDTotComp] varchar(11) NOT NULL,
    [drvYTDHrsWorkamt] int NULL,
    [drvYTDHrsWork] varchar(4) NOT NULL,
    [drvfreq] char(1) NULL,
    [drvaddress1] varchar(255) NULL,
    [drvaddress2] varchar(255) NULL,
    [drvcity] varchar(255) NULL,
    [drvstate] varchar(255) NULL,
    [drvzipcode] varchar(50) NULL,
    [drvcountry] char(3) NULL,
    [drvdob] varchar(8000) NULL,
    [drvhiredate] varchar(8000) NULL,
    [drvplandate] char(8) NULL,
    [drvtermdate] varchar(8000) NULL,
    [drvrehiredt] varchar(8000) NULL,
    [drvstatus] varchar(1) NULL,
    [drvrptdivision] varchar(10) NULL,
    [drvaltkey1] char(1) NULL,
    [drvaltkey2] varchar(10) NULL,
    [drvworkphone] varchar(12) NULL,
    [drvBenefitStatusReason] char(1) NULL,
	drvEmailAddress varchar(50) NULL,
	drvTransferIndicator varchar(1) NULL
);
IF OBJECT_ID('U_dsi_ESCHWABTES_drvtrl') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWABTES_drvtrl] (
    [drvpedate] varchar(8000) NULL,
    [drvsource1tot] varchar(24) NULL,
    [drvsource3tot] varchar(24) NULL,
    [drvsource4tot] varchar(24) NULL,
    [drvsource5tot] varchar(24) NULL,
    [drvsource6tot] varchar(24) NULL,
    [drvloan1tot] varchar(24) NULL
);
IF OBJECT_ID('U_dsi_ESCHWABTES_YTDdedamts') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWABTES_YTDdedamts] (
    [eedeeid] char(12) NOT NULL,
    [eedcoid] char(5) NOT NULL,
    [dedcode] varchar(7) NULL,
    [eeYTDamt] money NULL,
    [erYTDamt] money NULL
);
IF OBJECT_ID('U_dsi_ESCHWABTES_YTDearnamts') IS NULL
CREATE TABLE [dbo].[U_dsi_ESCHWABTES_YTDearnamts] (
    [eeeeeid] char(12) NOT NULL,
    [eeecoid] char(5) NOT NULL,
    [eeYTDhrs] decimal NULL,
    [eeYTDamt] money NULL
);
IF OBJECT_ID('U_ESCHWABTES_EEList') IS NULL
CREATE TABLE [dbo].[U_ESCHWABTES_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESCHWABTES_EEList_401k') IS NULL
CREATE TABLE [dbo].[U_ESCHWABTES_EEList_401k] (
    [xeeid] char(12) NULL,
    [xcoid] char(5) NULL
);
IF OBJECT_ID('U_ESCHWABTES_File') IS NULL
CREATE TABLE [dbo].[U_ESCHWABTES_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(528) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESCHWABTES]
    @systemid char(12)
AS
/************************************************************
Client: Summit Medical Group     

Created By: Ellen Havdahl
Business Analyst: Fernando Gutierrez             
Create Date: 03/04/2010
ChangePoint Request Number: 27572

Purpose: 401K export for Charles Schwab TEST
-- PRIMARY KEY CONSTRAINT = '7X1T7L0010K0'

Revision History
-----------------
Update By            Date            CP Num                Desc 
Ellen Havdahl        3/4/2010        27572                Initial  Code      
Tanya Leonce        11/14/2014        SR-2014-00065512    Updates Per Spec v2.3 - Update "Alternate Key #2"
Dave Smith            2/22/2018        SR-2018-00183882    Added benefit status field in column 29

10/25/2021 by AP:
		- Added email field and transfer indicator field.
		- Added logic to show "X" for transfer indicator.
		- Cleaned up new file field counts to accommodate for new fields.

SELECT * FROM U_Dsi_Configuration WHERE FormatCode = 'ESCHWABTES'
SELECT * FROM U_Dsi_SqlClauses WHERE FormatCode = 'ESCHWABTES'
SELECT * FROM U_Dsi_parameters WHERE FormatCode = 'ESCHWABTES'
SELECT * FROM AscExp WHERE ExpFormatCode = 'ESCHWABTES'
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESCHWABTES' ORDER BY RunID DESC;



EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESCHWABTES', @AllObjects = 'Y', @IsWeb = 'N'

EXEC dbo.dsi_sp_testswitchbox_v2 'ESCHWABTES', 'ESCHWABTES'
EXEC dbo.dsi_sp_testswitchbox_v2 'ESCHWABTES', 'TEST'
************************************************************/
BEGIN


    /**********************************
    DROP TABLE IF IT ALREADY EXISTS
    ***********************************/

    IF object_id ('U_ESCHWABTES_EEList_401k') IS NOT NULL
        DROP TABLE dbo.U_ESCHWABTES_EEList_401k
    IF object_id ('U_dsi_ESCHWABTES_drvtbl') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWABTES_drvtbl
    IF object_id ('U_dsi_ESCHWABTES_drvtrl') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWABTES_drvtrl
    IF object_id ('U_dsi_ESCHWABTES_curdedamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWABTES_curdedamts
    IF object_id ('U_dsi_ESCHWABTES_YTDdedamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWABTES_YTDdedamts
    IF object_id ('U_dsi_ESCHWABTES_curearnamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWABTES_curearnamts
    IF object_id ('U_dsi_ESCHWABTES_YTDearnamts') IS NOT NULL
        DROP TABLE dbo.U_dsi_ESCHWABTES_YTDearnamts


    /*********************************************
    Declare date variables to use for filtering
    **********************************************/
    DECLARE @startdate datetime,
            @enddate datetime,
            @startpc char(9),
            @endpc char(9)


    /**********************************
      RUN EXPORT
    ***********************************/
    SELECT @startdate = convert(datetime,SUBSTRING(StartPercontrol,1,8)),
           @enddate = convert(datetime,SUBSTRING(EndPerControl,1,8)),
           @startpc = startpercontrol,
           @endpc = endpercontrol
    FROM dbo.U_dsi_Parameters
    WHERE formatcode = 'ESCHWABTES'



    /****************************************
     GET EMPLOYEES FOR DETAIL RECORD
    ****************************************/

    select distinct xeeid, xcoid 
    into dbo.U_ESCHWABTES_EEList_401k
    from dbo.U_ESCHWABTES_EEList with (nolock) 
    join dbo.empcomp with (nolock) on eeceeid = xeeid and eeccoid = xcoid
    where eecemplstatus <> 'T' or 
    (
        eecemplstatus = 'T' and 
        ( 
            year(eecdateoftermination) = year(@startdate) 
            or 
            year(eecdateoftermination) = year(@enddate)
            -- HEG - 20110310
            or
            year(eecdateoftermination) = year(@startdate) - 1 -- prev yr
            or 
            year(eecdateoftermination) = year(@enddate) - 1 -- prev yr
        )
    )

	
    /***************************************************
    CREATE TABLE WITH DATA ELEMENTS - 401k Detail record  
    ****************************************************/

    SELECT            
        drveeid = eeceeid,
        drvcoid = eeccoid,
        drvssn = eepssn,
        drvlastname = eepnamelast,
        drvfirstname = eepnamefirst,
        drvmiddlename = left(eepnamemiddle,1),
        drv401KREGamt = convert(money,0), 
        drv401KREG = '00000000000',
        drvMATCHamt = convert(money,0), 
        drvMATCH = '00000000000',
        drvPROFITSHAREamt = convert(money,0),
        drvPROFITSHARE = '00000000000',
        drv401KROTHamt = convert(money,0), 
        drv401KROTH = '00000000000',
        drvSAFEHARBORamt = convert(money,0),
        drvSAFEHARBOR = '00000000000',
        drvloanamt = convert(money,0),
        drvloan = '00000000000',
        drvPerTotCompamt = convert(money,0),
        drvPerTotComp = '00000000000',
        drvPerHrsWorkamt = convert(int,0),
        drvPerHrsWork = '0000',
        drvYTD401Kamt = convert(money,0),
        drvYTD401K = '00000000000',
        drvYTDMATCHamt = convert(money,0), 
        drvYTDMATCH = '00000000000',
        drvYTDPSamt = convert(money,0),
        drvYTDPS = '00000000000',
        drvYTDROTHamt = convert(money,0), 
        drvYTDROTH = '00000000000',
        drvYTDSHamt = convert(money,0),
        drvYTDSH = '00000000000',
        drvYTDTotCompamt = convert(money,0),
        drvYTDTotComp = '00000000000',
        drvYTDHrsWorkamt = convert(int,0),
        drvYTDHrsWork = '0000',
        drvfreq = eecpayperiod,
        drvaddress1 = eepaddressline1,
        drvaddress2 = eepaddressline2,
        drvcity = eepaddresscity,         
        drvstate = eepaddressstate,      
        drvzipcode = case when len(eepaddresszipcode) = 5 then eepaddresszipcode
                    else left(eepaddresszipcode,5) + '-' + substring(eepaddresszipcode,6,4) end,
        drvcountry = eepaddresscountry,
        drvdob = replace(convert(char(10),eepdateofbirth,101),'/',''),
        drvhiredate = replace(convert(char(10),eecdateoforiginalhire,101),'/',''),
        drvplandate = convert(char(8),NULL),
        drvtermdate = replace(convert(char(10),eecdateoftermination,101),'/',''),
        drvrehiredt = case when eecdateoflasthire <> eecdateoforiginalhire then replace(convert(char(10),eecdateoflasthire,101),'/','') end,
        drvstatus = case when eepdatedeceased is not NULL then 'X'
                       when eectermreason = '202' then 'R'
                       else eecemplstatus end,
        drvrptdivision = eecorglvl4,
        drvaltkey1 = eepgender,
        drvaltkey2 = EecOrgLvl2,        -- 11/14/2014, TL - Replaced cmpcompanycode
        drvworkphone = case when cmpphonenumber is not NULL then left(cmpphonenumber,3) + '-' + substring(cmpphonenumber,4,3) + '-' + substring(cmpphonenumber,7,4) 
                                                          else ' ' end  , 
        --SR-2018-00183882
        drvBenefitStatusReason =    CASE 
                                        WHEN PNPSE.EedBenStatus IS NOT NULL AND PNPSP.EedBenStatus IS NULL THEN PNPSE.EedBenStatus
                                        WHEN PNPSE.EedBenStatus = 'T' AND PNPSP.EedBenStatus = 'A' THEN PNPSP.EedBenStatus
                                        ELSE ISNULL(PNPSE.EedBenStatus,PNPSP.EedBenStatus)
        END,
		drvEmailAddress = EepAddressEmail,
		drvTransferIndicator = '' --CASE WHEN EecEmplStatus = 'T' THEN 'X' ELSE '' END
    into dbo.U_dsi_ESCHWABTES_drvtbl
    from dbo.U_ESCHWABTES_EEList_401k
    join dbo.empcomp with (nolock) on eeceeid = xeeid and eeccoid = xcoid
    join dbo.emppers with (nolock) on eeceeid = eepeeid
    join dbo.company with (nolock) on cmpcoid = eeccoid
    --SR-2018-00183882 - added supporting tables to pull specific deduction details for PNPSE and PNPSP
    LEFT OUTER JOIN dbo.EmpDed AS PNPSE WITH (NOLOCK) on PNPSE.EedEEID = xeeid AND PNPSE.EedCoID = xcoid AND PNPSE.EedDedCode = 'PNPSE'
    LEFT OUTER join dbo.EmpDed AS PNPSP WITH (NOLOCK) on PNPSP.EedEEID = xeeid AND PNPSP.EedCoID = xcoid AND PNPSP.EedDedCode = 'PNPSP'

    /* update current ded amounts */
    SELECT
        pdheeid, 
        pdhcoid,
        case when pdhdedcode in ('401DE','401DP') then 'source1' 
           when pdhdedcode in ('401ME','401MP') then 'source3' 
           when pdhdedcode in ('PNPSE','PNPSP') then 'source4' 
           when pdhdedcode in ('401RE','401RP') then 'source5' 
           when pdhdedcode in ('PNSHE','PNSHP') then 'source6' 
           when pdhdedcode in ('401KL') then 'loan1' end as dedcode,
        sum(case when pdhdedcode in ('401dp','401rp') then 0 else pdheecuramt end) as eecuramt,
        sum(case when pdhdedcode in ('401de','401re') then 0 else pdhercuramt end) as ercuramt
    into dbo.U_dsi_ESCHWABTES_curdedamts
    from dbo.pdedhist with (nolock)
    join dbo.U_dsi_ESCHWABTES_drvtbl with (nolock) on drveeid = pdheeid and drvcoid = pdhcoid
    where pdhdedcode in ('401DE','401DP','401ME','401MP','PNPSE','PNPSP','401RE','401RP','PNSHE','PNSHP','401KL')
    and pdhpercontrol between @startpc and @endpc
    group by pdheeid, pdhcoid,
      case when pdhdedcode in ('401DE','401DP') then 'source1' 
           when pdhdedcode in ('401ME','401MP') then 'source3' 
           when pdhdedcode in ('PNPSE','PNPSP') then 'source4' 
           when pdhdedcode in ('401RE','401RP') then 'source5' 
           when pdhdedcode in ('PNSHE','PNSHP') then 'source6' 
           when pdhdedcode in ('401KL') then 'loan1' end

	---- TRANSFER COMPANY ANALYSIS ----
	IF OBJECT_ID('U_ESCHWABTES_Transfer','U') IS NOT NULL
    DROP TABLE dbo.U_ESCHWABTES_Transfer;

	SELECT *, ROW_NUMBER() OVER(PARTITION by drveeid order by drvtermdate) as rn
	INTO dbo.U_ESCHWABTES_Transfer
	FROM dbo.U_dsi_ESCHWABTES_drvtbl

	IF OBJECT_ID('U_ESCHWABTES_Transfer_Final','U') IS NOT NULL
    DROP TABLE dbo.U_ESCHWABTES_Transfer_Final;

	SELECT *, drveeid as teeid, drvcoid as tcoid, 'X' as tid
	INTO dbo.U_ESCHWABTES_Transfer_Final
	FROM dbo.U_ESCHWABTES_Transfer 
	WHERE rn > 1 
	AND drvStatus = 'T'
	-----------------------------------

	UPDATE dbo.U_dsi_ESCHWABTES_drvtbl
	SET drvTransferIndicator = tid
	FROM dbo.U_dsi_ESCHWABTES_drvtbl a JOIN dbo.U_ESCHWABTES_Transfer_Final b
	ON a.drveeid = b.teeid AND a.drvcoid = b.tcoid

    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drv401KREGamt = eecuramt+ercuramt,
        drv401KREG = dbo.dsi_fnPadZero((eecuramt+ercuramt)*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source1'


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvMATCHamt = ercuramt,
        drvMATCH = dbo.dsi_fnPadZero(ercuramt*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source3'


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvPROFITSHAREamt = ercuramt,
        drvPROFITSHARE = dbo.dsi_fnPadZero(ercuramt*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source4'


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drv401KROTHamt = eecuramt+ercuramt,
        drv401KROTH = dbo.dsi_fnPadZero((eecuramt+ercuramt)*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source5'


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvSAFEHARBORamt = ercuramt,
        drvSAFEHARBOR = dbo.dsi_fnPadZero(ercuramt*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'source6'


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvLoanamt = eecuramt,
        drvLoan = dbo.dsi_fnPadZero(eecuramt*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_curdedamts with (nolock) on pdheeid = drveeid and pdhcoid = drvcoid
    where dedcode = 'loan1'


    /* update current earn amounts */
    select peheeid, pehcoid, sum(case when erninclindefcomphrs = 'Y' then pehcurhrs else 0 end) as eecurhrs,
           sum(case when erninclindefcomp = 'Y' then pehcuramt else 0 end) as eecuramt   
    into dbo.U_dsi_ESCHWABTES_curearnamts
    from dbo.pearhist with (nolock)
    join dbo.U_dsi_ESCHWABTES_drvtbl with (nolock) on drveeid = peheeid and drvcoid = pehcoid 
    join dbo.earncode on ernearncode = pehearncode
    where pehpercontrol between @startpc and @endpc
    group by peheeid, pehcoid

    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvPerTotCompamt = eecuramt,
        drvPerTotComp = dbo.dsi_fnPadZero(eecuramt*100,11,0),
        drvPerHrsWorkamt = eecurhrs,
        drvPerHrsWork = dbo.dsi_fnPadZero(eecurhrs,4,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_curearnamts  with (nolock) on peheeid = drveeid and pehcoid = drvcoid 


    /* update YTD ded amounts */
    SELECT
        eedeeid, 
        eedcoid,
        case when eeddedcode in ('401DE','401DP') then 'source1' 
           when eeddedcode in ('401ME','401MP') then 'source3' 
           when eeddedcode in ('PNPSE','PNPSP') then 'source4' 
           when eeddedcode in ('401RE','401RP') then 'source5' 
           when eeddedcode in ('PNSHE','PNSHP') then 'source6' end as dedcode, 
        sum(case when eeddedcode in ('401dp','401rp') then 0 else eedeeYTDamt end) as eeYTDamt,
        sum(case when eeddedcode in ('401de','401re') then 0 else eederYTDamt end) as erYTDamt
    into dbo.U_dsi_ESCHWABTES_YTDdedamts
    from dbo.empded with (nolock)
    join dbo.U_dsi_ESCHWABTES_drvtbl with (nolock) on drveeid = eedeeid and drvcoid = eedcoid
    where eeddedcode in ('401DE','401DP','401ME','401MP','PNPSE','PNPSP','401RE','401RP','PNSHE','PNSHP')
    group by eedeeid, eedcoid,
      case when eeddedcode in ('401DE','401DP') then 'source1' 
           when eeddedcode in ('401ME','401MP') then 'source3' 
           when eeddedcode in ('PNPSE','PNPSP') then 'source4' 
           when eeddedcode in ('401RE','401RP') then 'source5' 
           when eeddedcode in ('PNSHE','PNSHP') then 'source6' end 
      

    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvYTD401Kamt = eeYTDamt+erYTDamt,
        drvYTD401K = dbo.dsi_fnPadZero((eeYTDamt+erYTDamt)*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source1'


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvYTDMATCHamt = erYTDamt,
        drvYTDMATCH = dbo.dsi_fnPadZero(erYTDamt*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source3'


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvYTDPSamt = erYTDamt,
        drvYTDPS = dbo.dsi_fnPadZero(erYTDamt*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source4'


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvYTDROTHamt = eeYTDamt+erYTDamt,
        drvYTDROTH = dbo.dsi_fnPadZero((eeYTDamt+erYTDamt)*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source5'


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvYTDSHamt = erYTDamt,
        drvYTDSH = dbo.dsi_fnPadZero(erYTDamt*100,11,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_YTDdedamts with (nolock) on eedeeid = drveeid and eedcoid = drvcoid
    where dedcode = 'source6'


    /* update YTD earn amounts */
    select eeeeeid, eeecoid, sum(case when erninclindefcomphrs = 'Y' then eeeYTDhrs else 0 end) as eeYTDhrs,
           sum(case when erninclindefcomp = 'Y' then eeeYTDamt else 0 end) as eeYTDamt
    into dbo.U_dsi_ESCHWABTES_YTDearnamts
    from dbo.empearn with (nolock)
    join dbo.U_dsi_ESCHWABTES_drvtbl with (nolock) on drveeid = eeeeeid and drvcoid = eeecoid 
    join dbo.earncode on ernearncode = eeeearncode
    group by eeeeeid, eeecoid


    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvYTDTotCompamt = eeYTDamt,
        drvYTDTotComp = dbo.dsi_fnPadZero(eeYTDamt*100,11,0),
        drvYTDHrsWorkamt = eeYTDhrs,
        drvYTDHrsWork = dbo.dsi_fnPadZero(eeYTDhrs,4,0)
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join dbo.U_dsi_ESCHWABTES_YTDearnamts  with (nolock) on eeeeeid = drveeid and eeecoid = drvcoid 

    /* update Plan Entry Date */
    select eedeeid, eedcoid, eedeeeligdate
    into #PNPSE
    from dbo.empded
    where eeddedcode = 'PNPSE'
    and eedbenstopdate is NULL
      
    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvplandate = replace(convert(char(10),eedeeeligdate,101),'/','')
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join #PNPSE on eedeeid = drveeid and eedcoid = drvcoid
     
    select eedeeid, eedcoid, eedeeeligdate
    into #PNPSP
    from dbo.empded
    where eeddedcode = 'PNPSP'
    and eedbenstopdate is NULL
      
    update dbo.U_dsi_ESCHWABTES_drvtbl
    set drvplandate = replace(convert(char(10),eedeeeligdate,101),'/','')
    from dbo.U_dsi_ESCHWABTES_drvtbl
    join #PNPSP on eedeeid = drveeid and eedcoid = drvcoid
    where drvplandate is NULL


    /*************************************************************
    Build Trailer record
    *************************************************************/
        
    SELECT
        drvpedate = replace(Convert(char(10),(select max(pgpperiodenddate) from pgpayper where pgpperiodcontrol between @startpc and @endpc),101),'/',''),
        drvsource1tot = dbo.dsi_fnPadZero((select sum(drv401KREGamt) *100 from dbo.U_dsi_ESCHWABTES_drvtbl),11,0),
        drvsource3tot = dbo.dsi_fnPadZero((select sum(drvMATCHamt) *100 from dbo.U_dsi_ESCHWABTES_drvtbl),11,0),
        drvsource4tot = dbo.dsi_fnPadZero((select sum(drvPROFITSHAREamt) *100 from dbo.U_dsi_ESCHWABTES_drvtbl),11,0),
        drvsource5tot = dbo.dsi_fnPadZero((select sum(drv401KROTHamt) *100 from dbo.U_dsi_ESCHWABTES_drvtbl),11,0),
        drvsource6tot = dbo.dsi_fnPadZero((select sum(drvSAFEHARBORamt) *100 from dbo.U_dsi_ESCHWABTES_drvtbl),11,0),
        drvloan1tot = dbo.dsi_fnPadZero((select sum(drvLoanamt) *100 from dbo.U_dsi_ESCHWABTES_drvtbl),11,0)
    into dbo.U_dsi_ESCHWABTES_drvtrl



END
GO
Create View dbo.dsi_vwESCHWABTES_Export as
        select top 2000000 Data from dbo.U_ESCHWABTES_File with (nolock)
        order by substring(RecordSet,2,2), InitialSort

		--drop view dbo.dsi_vwESCHWABTES_Export

		--select *
		--from dsi_vwESCHWABTES_Export