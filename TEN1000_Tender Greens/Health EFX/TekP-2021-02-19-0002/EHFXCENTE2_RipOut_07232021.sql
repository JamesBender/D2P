SET NOCOUNT ON;
IF OBJECT_ID('U_EHFXCENTE2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHFXCENTE2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHFXCENTE2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHFXCENTE2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHFXCENTE2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHFXCENTE2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHFXCENTE2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFXCENTE2];
GO
IF OBJECT_ID('U_EHFXCENTE2_File') IS NOT NULL DROP TABLE [dbo].[U_EHFXCENTE2_File];
GO
IF OBJECT_ID('U_EHFXCENTE2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHFXCENTE2_EEList];
GO
IF OBJECT_ID('U_dsi_EHFXCENTE2_StatStack') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTE2_StatStack];
GO
IF OBJECT_ID('U_dsi_EHFXCENTE2_LOA') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTE2_LOA];
GO
IF OBJECT_ID('U_dsi_EHFXCENTE2_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTE2_EarnHist];
GO
IF OBJECT_ID('U_dsi_EHFXCENTE2_EarnCurrHC') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTE2_EarnCurrHC];
GO
IF OBJECT_ID('U_dsi_EHFXCENTE2_EarnCurr') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTE2_EarnCurr];
GO
IF OBJECT_ID('U_dsi_EHFXCENTE2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EHFXCENTE2_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHFXCENTE2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHFXCENTE2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHFXCENTE2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHFXCENTE2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHFXCENTE2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','EHFXCENTE2','Health E(fx) Census File V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EHFXCENTE2Z0','N','Sep 28 2016  4:35PM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHFXCENTE2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','1','(''DA''=''T|'')','EHFXCENTE2Z0','8','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TYP Restaurant Group"','2','(''DA''=''T|'')','EHFXCENTE2Z0','20','H','01','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FEIN"','3','(''DA''=''T|'')','EHFXCENTE2Z0','4','H','01','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Number"','4','(''DA''=''T|'')','EHFXCENTE2Z0','9','H','01','33',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','5','(''DA''=''T|'')','EHFXCENTE2Z0','3','H','01','42',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','6','(''DA''=''T|'')','EHFXCENTE2Z0','10','H','01','45',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name/Initial"','7','(''DA''=''T|'')','EHFXCENTE2Z0','19','H','01','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','8','(''DA''=''T|'')','EHFXCENTE2Z0','9','H','01','74',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','9','(''DA''=''T|'')','EHFXCENTE2Z0','9','H','01','83',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','10','(''DA''=''T|'')','EHFXCENTE2Z0','9','H','01','92',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','11','(''DA''=''T|'')','EHFXCENTE2Z0','4','H','01','101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','12','(''DA''=''T|'')','EHFXCENTE2Z0','5','H','01','105',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','13','(''DA''=''T|'')','EHFXCENTE2Z0','3','H','01','110',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Email"','14','(''DA''=''T|'')','EHFXCENTE2Z0','13','H','01','113',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone Number"','15','(''DA''=''T|'')','EHFXCENTE2Z0','12','H','01','126',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','16','(''DA''=''T|'')','EHFXCENTE2Z0','6','H','01','138',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','17','(''DA''=''T|'')','EHFXCENTE2Z0','13','H','01','144',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Hire Date"','18','(''DA''=''T|'')','EHFXCENTE2Z0','18','H','01','157',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','19','(''DA''=''T|'')','EHFXCENTE2Z0','11','H','01','175',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Term Date"','20','(''DA''=''T|'')','EHFXCENTE2Z0','9','H','01','186',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Code"','21','(''DA''=''T|'')','EHFXCENTE2Z0','8','H','01','195',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Description"','22','(''DA''=''T|'')','EHFXCENTE2Z0','15','H','01','203',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Full/Part Time Code"','23','(''DA''=''T|'')','EHFXCENTE2Z0','19','H','01','218',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','24','(''DA''=''T|'')','EHFXCENTE2Z0','17','H','01','237',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOA Code"','25','(''DA''=''T|'')','EHFXCENTE2Z0','8','H','01','254',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOA Reason"','26','(''DA''=''T|'')','EHFXCENTE2Z0','10','H','01','262',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOA Begin Date"','27','(''DA''=''T|'')','EHFXCENTE2Z0','14','H','01','272',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LOA End Date"','28','(''DA''=''T|'')','EHFXCENTE2Z0','12','H','01','286',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Region"','29','(''DA''=''T|'')','EHFXCENTE2Z0','6','H','01','298',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work City"','30','(''DA''=''T|'')','EHFXCENTE2Z0','9','H','01','304',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary/Hourly Code"','31','(''DA''=''T|'')','EHFXCENTE2Z0','18','H','01','313',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Rate"','32','(''DA''=''T|'')','EHFXCENTE2Z0','11','H','01','331',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status Change Date"','33','(''DA''=''T|'')','EHFXCENTE2Z0','18','H','01','341',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','34','(''DA''=''T'')','EHFXCENTE2Z0','18','H','01','359',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','1','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','1',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTypGroup"','2','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','36',NULL,'TYP Restaurant Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFEIN"','3','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','71',NULL,'FEIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','4','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','106',NULL,'EE Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','141',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','176',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','211',NULL,'Middle Name/Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','246',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','9','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','281',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','10','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','316',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','351',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','12','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','386',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','13','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','421',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','14','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','456',NULL,'Primary Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','15','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','491',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','16','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','526',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','17','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','561',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrigDOH"','18','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','596',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','19','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','631',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOT"','20','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','666',NULL,'Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','21','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','701',NULL,'Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobDesc"','22','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','736',NULL,'Job Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFTorPT"','23','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','771',NULL,'Full/Part Time Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkStatus"','24','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','806',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAcode"','25','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','841',NULL,'LOA Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAreason"','26','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','876',NULL,'LOA Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAstartDate"','27','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','911',NULL,'LOA Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAendDate"','28','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','946',NULL,'LOA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRegion"','29','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','981',NULL,'Region',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCity"','30','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','1016',NULL,'Work City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalHrlyCode"','31','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','1051',NULL,'Salary/Hourly Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyRate"','32','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','1086',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatChgDate"','33','(''UA''=''T|'')','EHFXCENTE2Z0','35','D','02','1096',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','34','(''UA''=''T'')','EHFXCENTE2Z0','35','D','02','2010',NULL,'Annual Salary',NULL,NULL);

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EHFXCENTE2_20210723.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','IAGFG',NULL,NULL,NULL,'EHFXCENTE2 export','202104169','EMPEXPORT','EHFXCENTE2',NULL,'EHFXCENTE2',NULL,NULL,NULL,'202104169',NULL,NULL,'202104021',NULL,'','','202104021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'TEST','202107209','EMPEXPORT','TEST','Jul 20 2021  5:53PM','EHFXCENTE2',NULL,NULL,NULL,'202107209','Jul 20 2021 12:00AM','Dec 30 1899 12:00AM','202107011','1154','','','202107011',dbo.fn_GetTimedKey(),NULL,'us3lKiTEN1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','ExportDescription','C','Health E(fx) Census File');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','FileType','C','txt');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','MaxFileLength','C','2000');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','SystemID','V','318A128B5C8A');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFXCENTE2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EHFXCENTE2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EHFXCENTE2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EHFXCENTE2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHFXCENTE2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHFXCENTE2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHFXCENTE2','D02','dbo.U_dsi_EHFXCENTE2_drvTbl',NULL);
IF OBJECT_ID('U_dsi_EHFXCENTE2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTE2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvsort1] int NOT NULL,
    [drvsort2] char(11) NULL,
    [drvLocation] char(6) NULL,
    [drvTypGroup] varchar(20) NOT NULL,
    [drvFEIN] varchar(10) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(52) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] varchar(10) NULL,
    [drvOrigDOH] varchar(10) NULL,
    [drvRehireDate] varchar(10) NULL,
    [drvDOT] varchar(10) NULL,
    [drvJobCode] char(8) NULL,
    [drvJobDesc] varchar(25) NOT NULL,
    [drvFTorPT] varchar(2) NOT NULL,
    [drvWorkStatus] varchar(45) NULL,
    [drvLOAcode] char(6) NULL,
    [drvLOAreason] char(6) NULL,
    [drvLOAstartDate] varchar(10) NULL,
    [drvLOAendDate] varchar(10) NULL,
    [drvRegion] char(10) NULL,
    [drvWorkCity] varchar(255) NULL,
    [drvSalHrlyCode] char(1) NULL,
    [drvHourlyRate] money NULL,
    [drvStatChgDate] varchar(10) NULL,
	drvAnnualSalary varchar(10) NULL
);
IF OBJECT_ID('U_dsi_EHFXCENTE2_EarnCurr') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTE2_EarnCurr] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [epercontrol] char(9) NOT NULL,
    [ecuramt] money NULL,
    [ecurhrs] decimal NULL
);
IF OBJECT_ID('U_dsi_EHFXCENTE2_EarnCurrHC') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTE2_EarnCurrHC] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [ecurHCamt] money NULL,
    [ecurHChrs] decimal NULL
);
IF OBJECT_ID('U_dsi_EHFXCENTE2_EarnHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTE2_EarnHist] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);
IF OBJECT_ID('U_dsi_EHFXCENTE2_LOA') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTE2_LOA] (
    [leeid] char(12) NULL,
    [lcoid] char(5) NULL,
    [loa_date] datetime NULL,
    [return_date] datetime NULL,
    [lreason] char(6) NULL
);
IF OBJECT_ID('U_dsi_EHFXCENTE2_StatStack') IS NULL
CREATE TABLE [dbo].[U_dsi_EHFXCENTE2_StatStack] (
    [seeid] char(12) NOT NULL,
    [scoid] char(5) NOT NULL,
    [sstat] char(1) NULL,
    [sdate] datetime NULL,
    [sreason] char(6) NULL,
    [sNo] bigint NULL
);
IF OBJECT_ID('U_EHFXCENTE2_EEList') IS NULL
CREATE TABLE [dbo].[U_EHFXCENTE2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHFXCENTE2_File') IS NULL
CREATE TABLE [dbo].[U_EHFXCENTE2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EHFXCENTE2'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EHFXCENTE2',GetDate(),'P','V1.TD'
*/

/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EHFXCENTE2'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EHFXCENTE2',GetDate(),'P','V1.TD'
*/

CREATE   PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFXCENTE2]
 @systemid varchar(12) = ''
AS
Begin

/**********************************************************************************
Client Name: Tender Greens

Created By: Guido Pozo
Business Analyst: Charon Covington
Create Date: 09/28/2016
Service Request Number: SF#07494906

Purpose: Health E(fx) - Census File

Revision History
----------------
07/09/2021 by AP:
        - Updated logic for audit which was affecting status change. See lines 629-631.

07/20/2021 by AP:
        - Set back EmpComp as the audit driver for EecFullTimeOrPartTime.
        - Removed test employees.

07/23/2021 by AP:
		- Updated Status Change Date field to most recent ejhjobeffdate.
		- Added Annual Salar field.
        
Inshan Singh         05.05.2021      TekP-2021-02-19-0002       Fixed duplicate issue caused by drvStatChgDate field
Chelsea Bartholomew     10.10.2018         12489430                    Added logic removing employees with SSNs like 99999999%


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHFXCENTE2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHFXCENTE2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHFXCENTE2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EHFXCENTE2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHFXCENTE2' ORDER BY DateTimeCompleted DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHFXCENTE2', 'EHFXCENTE2';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHFXCENTE2', 'TEST';        --\\us.saas\ew2\WP7\Downloads\V10\Exports\TEN\EmployeeHistoryExport\
EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHFXCENTE2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHFXCENTE2', @AllObjects = 'Y', @IsWeb='Y';
**********************************************************************************/

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
        @FormatCode = formatcode,
        @ExportCode = Exportcode,
        @Exportfile = ExportFile
    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID

-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 30    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'N'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe

-- clean up EELIST if needed


    -----------
    -- Audit Code - Get Old 'DedGroupCode' Value
    -----------
    IF OBJECT_ID('U_EHFXCENTE2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHFXCENTE2_Audit;
/*    SELECT audEEID = audKey1Value 
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EHFXCENTE2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK)
    WHERE 
        audDateTime BETWEEN @StartDate AND @EndDate
        --audDateTime > @EndDate
    AND audTableName = 'EmpComp'
    AND audFieldName = 'EecFullTimeOrPartTime';*/


    /*SELECT audEEID = audKey1Value 
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        --,audKey3Label
        ,audTableName
        ,audFieldName
        ,audAction
        ,EjhJobEffDate
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value,  audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EHFXCENTE2_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK)
    JOIN dbo.EmpHJob WITH (NOLOCK)
        ON audKey1Value = EjhEEID
        AND audKey2Value = EjhCOID    
        AND EjhJobEffDate  BETWEEN @StartDate AND @EndDate
    WHERE 
        --audDateTime 
        --EjhJobEffDate 
        --BETWEEN '1/1/2021' AND '4/13/2021' -- 2021-02-23 15:47:29.563, effective date is 3/1/2021
        --audDateTime > @EndDate
    --AND 
    audTableName = 'EmpHJob' -- 'EmpComp'
    AND audFieldName = 'EjhFullTimeOrPartTime' --'EecFullTimeOrPartTime'*/


    
-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_EHFXCENTE2_EELIST
            from dbo.u_EHFXCENTE2_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end

-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_EHFXCENTE2_EELIST
            from dbo.u_EHFXCENTE2_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_EHFXCENTE2_eelist
            from dbo.u_EHFXCENTE2_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_EHFXCENTE2_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--keep terms on the file for 120 days
delete dbo.u_EHFXCENTE2_eelist
where xeeid+xcoid in (select eeceeid+EecCoID from empcomp where eecemplstatus = 'T' and eecdateoftermination + 120 < @EndDate)

--TD 7/10/15 remove ee's with 00000 ssn's
delete dbo.u_EHFXCENTE2_eelist
from dbo.u_EHFXCENTE2_eelist
join emppers ep with (nolock) on xeeid = ep.eepEEID
where ep.eepSSN like '00000%'
or ep.eepSSN like '12345%' or eepSSN like '666%' or eepSSN like '333%' or eepSSN like '99999999%' --CAB1010


-- Build earning history YTD

if object_id('U_dsi_EHFXCENTE2_EarnHist') is not null
  drop table dbo.U_dsi_EHFXCENTE2_EarnHist

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

    INTO dbo.U_dsi_EHFXCENTE2_EarnHist
        from dbo.u_EHFXCENTE2_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
        --TD 12/08/15 added HOT
        --TD 12/11/15 added JRYDY, BEREV & STIP
        AND PehEarnCode in ('1099','ANNIV','BEREV','BONUS','CTIPS','DT','FDCRD','JRYDY','HOL','HOT','MEAL','MIL','OT','PHONE','PTO','REG','RETRO','SAL','SICK','STIP','TRAIN','TRANS')                            
        --AND pehPerControl between @StartPerControl and @EndPerControl       --Period
    GROUP BY xEEID,xCOID--,pehearncode

--select * from dbo.U_dsi_EHFXCENTE2_EarnHist

-- Build earning this ppd

if object_id('U_dsi_EHFXCENTE2_EarnCurr') is not null
  drop table dbo.U_dsi_EHFXCENTE2_EarnCurr
--select * from  U_dsi_EHFXCENTE2_EarnCurr order by eeeid

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    PehPerControl epercontrol,
    SUM(ISNULL(pehCurAmt,0.00)) AS ecuramt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ecurhrs

    INTO dbo.U_dsi_EHFXCENTE2_EarnCurr
        from dbo.u_EHFXCENTE2_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        AND pehPERCONTROL BETWEEN @StartPerControl and @EndPerControl 
        --TD 12/08/15 added HOT
        --TD 12/11/15 added JRYDY, BEREV & STIP
        AND PehEarnCode in ('1099','ANNIV','BEREV','BONUS','CTIPS','DT','FDCRD','JRYDY','HOL','HOT','MEAL','MIL','OT','PHONE','PTO','REG','RETRO','SAL','SICK','STIP','TRAIN','TRANS')                            

    GROUP BY xEEID,xCOID,PehPerControl--,pehearncode

-- Build HealthCare Hours this ppd

if object_id('U_dsi_EHFXCENTE2_EarnCurrHC') is not null
  drop table dbo.U_dsi_EHFXCENTE2_EarnCurrHC
--select * from  U_dsi_EHFXCENTE2_EarnCurrHC order by eeeid

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
--    pehpaydate epaydate,
    SUM(ISNULL(pehCurAmt,0.00)) AS ecurHCamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ecurHChrs

    INTO dbo.U_dsi_EHFXCENTE2_EarnCurrHC
        from dbo.u_EHFXCENTE2_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        AND pehPERCONTROL BETWEEN @StartPerControl and @EndPerControl 
    JOIN EarnCode on ErnEarncode = PehEarnCode and ErnInclInHealthCareHours = 'Y'

    GROUP BY xEEID,xCOID,pehpaydate--,pehearncode


-- LOA logic - 10/19/2016

    if object_id('dbo.U_dsi_EHFXCENTE2_StatStack') is not null
      drop table dbo.U_dsi_EHFXCENTE2_StatStack

    select esheeid seeid, eshcoid scoid, eshemplstatus sstat,eshstatusstartdate sdate, eshemplstatusreason sreason,
    ROW_NUMBER() OVER (PARTITION BY eshEEID ORDER BY eshstatusstartdate desc) sNo
    into dbo.U_dsi_EHFXCENTE2_StatStack
    from emphstat

    --select * from dbo.U_dsi_EHFXCENTE2_StatStack where seeid = '8XDC0U0000K0'


    if object_id('dbo.U_dsi_EHFXCENTE2_LOA') is not null
      drop table dbo.U_dsi_EHFXCENTE2_LOA

--    select xeeid leeid, xcoid lcoid, l.sdate loa_date,r.sdate return_date, L.sreason lreason
--    select xeeid leeid, xcoid lcoid, max(l.sdate) loa_date,max(r.sdate) return_date, L.sreason lreason    --Get Maximum LOA only

    -- Is Status Next Status after LOA is 'T' then populate the status date minus 1 day.(12/2/2016)
    select xeeid leeid, xcoid lcoid, max(l.sdate) loa_date,max( Case when r.sstat = 'T' then r.sdate-1 else r.sdate end) return_date, L.sreason lreason    --Get Maximum LOA only
    into dbo.U_dsi_EHFXCENTE2_LOA
    from dbo.U_EHFXCENTE2_EEList
    join U_dsi_EHFXCENTE2_StatStack L on xeeid = l.seeid and xcoid = l.scoid and l.sstat = 'L'
    --left join U_dsi_EHFXCENTE2_StatStack R on xeeid = r.seeid and xcoid = r.scoid and r.sstat = 'A' and r.sno = l.sno - 1
    left join U_dsi_EHFXCENTE2_StatStack R on xeeid = r.seeid and xcoid = r.scoid and (r.sstat = 'A' or r.sstat = 'T') and r.sno = l.sno - 1    --(12/2/2016)
    group by xeeid,xcoid,L.sreason                                                                        --Get Maximum LOA only
    
    
    -- select * from dbo.U_dsi_EHFXCENTE2_LOA where leeid = '8XDC0U0000K0'

-- Populate Source for Employees

if object_id('dbo.U_dsi_EHFXCENTE2_drvTbl') is not null
  drop table dbo.U_dsi_EHFXCENTE2_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvsort1 = 2,
    drvsort2 = eepssn,
-- standard fields above and additional driver fields below
    drvLocation = eecLocation,
    drvTypGroup = 'TYP Restaurant Group',
    drvFEIN = '20-1058272',
    drvEmpNo = EecEmpNo,
    drvSSN = eepssn,
    drvNameFirst = RTRIM(eepnamefirst),
    drvNameMiddle = RTRIM(eepnamemiddle),
    drvNameLast = RTRIM(eepnamelast),
    drvAddress1 = EepAddressLine1,
    drvAddress2 = EepAddressLine2,
    drvCity = EepAddressCity,
    drvState = EepAddressState,
    drvZip = eepaddresszipcode,
    drvEmail = eepAddressEMail,
    drvPhone = case when isnull(EepPhoneHomeNumber,'') <> '' then Stuff(Stuff(eepPhoneHomeNumber,7,0,'-'),4,0,'-') else '' end, --TD 8/5/15 --OPT
    drvGender = EepGender, --TD 8/5/15 --OPT
    drvDOB = CONVERT(varchar(10), EepDateOfBirth, 112),
    drvOrigDOH = CONVERT(varchar(10), EecDateOfOriginalHire, 112),
    drvRehireDate = case when EecDateOfLastHire > EecDateOfOriginalHire then CONVERT(varchar(10), EecDateOfLastHire, 112) else '' end,
    drvDOT = case when EecEmplStatus = 'T' and ISNULL(eecdateoftermination,'') <> '' then CONVERT(varchar(10), EecDateOfTermination, 112) else '' end,
    drvJobCode = EecJobCode, --TD 8/5/15 --OPT
    drvJobDesc = jbcDesc, --TD 8/5/15 --OPT
    drvFTorPT = case when EecFullTimeOrPartTime = 'F' then 'FT'
                     when EecFullTimeOrPartTime = 'P' then 'PT'
                else '' end,
    drvWorkStatus = estat.descr,
    drvLOAcode = loa.LchType,
    drvLOAreason = lreason,    --loa.lchCode,
    drvLOAstartDate = CONVERT(varchar(10), loa_date, 112),        --CONVERT(varchar(10), loa.EshStatusStartDate, 112),
    drvLOAendDate = CONVERT(varchar(10), return_date, 112),                            --10/19/16 loa.EshStatusStopDate
    drvRegion = EecOrgLvl2, --TD 8/5/15 as requested
    drvWorkCity = LocAddressCity,    --TD 7/10/15 added --OPT
    drvSalHrlyCode = EecSalaryOrHourly,
/*
    drvPeriodHours = case when ecurhrs >= 0 then cast(ecurhrs/*ecurHChrs*/ as varchar) end, --TD 7/21/15 as requested.
    drvPayFreq = case when EecPayPeriod = 'W' then 'Weekly'
                      when EecPayPeriod = 'B' then 'Bi-Weekly'
                      when EecPayPeriod = 'S' then 'Semi-monthly'
                      when EecPayPeriod = 'M' then 'Monthly' else '' end,
    drvGrossYTD = case when eamt >= 0 then ISNULL(eamt,0) end, --TD 7/21/15 as requested.
    drvGrossPeriod = case when ecuramt >=0 then isnull(ecuramt,0) end,
*/
    drvHourlyRate = CAST(EecHourlyPayRate as money)    --case when eecemplstatus <> 'T' then CAST(EecHourlyPayRate as money) end,
--        drvPeriodStartDate = CONVERT(varchar(10), PgpPeriodStartDate, 112),--case when eecemplstatus <> 'T' then CONVERT(varchar(10), PgpPeriodStartDate, 112) end,
--        drvPeriodEndDate = CONVERT(varchar(10), PgpPeriodEndDate, 112)--case when eecemplstatus <> 'T' then CONVERT(varchar(10), PgpPeriodEndDate, 112) end
    ,drvStatChgDate = CONVERT(VARCHAR(10), EjhJobEffDate, 112)
                        --CASE WHEN AudNewValue IS NOT NULL THEN CONVERT(VARCHAR(10), EjhJobEffDate, 112) END
	,drvAnnualSalary = CAST(EecAnnSalary AS VARCHAR)

  into dbo.U_dsi_EHFXCENTE2_drvTbl
  from dbo.u_EHFXCENTE2_eelist with (nolock)
    join empPers with (nolock) on     xEEID = eepEEID
    join empcomp with (nolock) on    xEEID = eecEEid and     xCOID = eecCOID
    join Location with (nolock) on LocCode = EecLocation
    join jobcode with (nolock) on eecJobCode = jbcJobCode

    left join (select codcode, coddesc descr from codes where codtable = 'EMPLOYEESTATUS') estat on estat.codcode = eecemplstatus

    left join dbo.U_dsi_EHFXCENTE2_EarnHist on xEEID = eEEID and xCOID = eCOID
    --left join dbo.U_dsi_EHFXCENTE2_EarnCurr ec on xEEID = ec.eEEID and xCOID = ec.eCOID 

    left join pgpayper with (nolock) on PgpPeriodControl between @StartPerControl and @EndPerControl and pgpperiodtype = 'R'    

    --TD 9/15/15 per request:
    --join dbo.U_dsi_EHFXCENTE2_EarnCurr ec on xEEID = ec.eEEID and xCOID = ec.eCOID and ec.epercontrol = PgpPeriodControl  --10/10/16 removed so that LOAs are included

    left join dbo.U_dsi_EHFXCENTE2_EarnCurrHC ecHC on xEEID = ecHC.eEEID and xCOID = ecHC.eCOID 

    left join (select eeceeid eeid, eeccoid coid, lchCode, lchDesc, lchFMLAQualified, lchType, eshStatusStartDate, eshStatusStopDate
        from empcomp
        left join emphstat on esheeid = eeceeid and eshemplstatus = 'L'
        join loareasn on lchcode = eecLeaveReason
        where eecemplstatus = 'L' 
        --and EshStatusStartDate between @StartDate and @EndDate                        --10/10/16 removed
        and eecemplstatusstartdate = eshstatusstartdate
        ) LOA on loa.eeid = xeeid and loa.coid = xcoid

    left join U_dsi_EHFXCENTE2_LOA LOAR on loar.leeid = xeeid
    /*LEFT JOIN dbo.U_EHFXCENTE2_Audit WITH (NOLOCK)
        ON xEEID = AudEEID
        AND xCOID = AudKey2
        AND audRowNo = 1*/
	OUTER APPLY (SELECT TOP 1 * FROM dbo.EmpHJob WITH(NOLOCK) WHERE EjhEEID = xEEID AND EjhCOID = xCOID ORDER BY EjhJobEffDate DESC) E

    --LEFT JOIN (
    --            SELECT  xEEID AS yEEID, xCOID AS yCOID, EjhJobEffDate AS yEjhJobEffDate
    --            FROM dbo.vw_AuditData WITH (NOLOCK)
    --            JOIN dbo.u_EHFXCENTE2_EELIST WITH (NOLOCK)
    --                ON AudKey1Value = xEEID
    --            JOIN (
    --                    SELECT EjhEEID, EjhCOID, EjhFullTimeOrPartTime, EjhJobEffDate
    --                    FROM (
    --                            SELECT EjhEEID, EjhCOID, EjhFullTimeOrPartTime, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
    --                            --SELECT EjhEEID, EjhCOID, EjhFullTimeOrPartTime, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID, EjhFullTimeOrPartTime ORDER BY EjhJobEffDate DESC) AS RN -- 05/05/2021 TekP-2021-02-19-0002 I. Singh Removed  EjhFullTimeOrPartTime from partition to prevent duplicate
    --                            FROM dbo.EmpHJob WITH (NOLOCK)
    --                        ) AS Ejh
    --                    WHERE RN = 1) AS X
    --                ON xEEID = EjhEEID
    --                AND xCOID = EjhCoID
    --                AND audNewValue = EjhFullTimeOrPartTime
    --            WHERE audTableName = 'EmpComp' --'EmpHJob' --audTableName = 'EmpComp' 
    --               AND audFieldName = 'EecFullTimeOrPartTime' --'EjhFullTimeOrPartTime' -- AND audFieldName =  'EEcFullTimeOrPartTime' 
    --               AND audAction = 'Update'
    --            ) AS Y
    --    ON xEEID = yEEID
    --    AND xCOID = yCOID
        ;

    DELETE dbo.U_dsi_EHFXCENTE2_drvTbl
    WHERE drvSSN IN ('615432101', '615587270', '777123456')  -- Remove test employees
    ;

--select * from dbo.U_dsi_EHFXCENTE2_drvTbl

-- Create Headers

-- Create Trailers

-- Set FileName  
--if (dbo.dsi_fnVariable('EHFXCENTE2','UseFileName') = 'N')
--  update dbo.U_dsi_Parameters
--    set ExportFile =  'TEN_HealthEfx_Payroll_' + convert(char(8),getdate(),112) + '.txt'
--    where FormatCode = 'EHFXCENTE2'

-- Remember to alter view for correct sorting
/*

 ALTER  View dbo.dsi_vwEHFXCENTE2_Export as
        select top 2000000 rtrim(Data) as Data
         from dbo.U_EHFXCENTE2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
                       when substring(Recordset,1,1) = 'D' then 2 end,
            initialsort, subsort, substring(Recordset,2,2)         



UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202104021'
       ,ExpStartPerControl     = '202104021'
       ,ExpLastEndPerControl   = '202104169'
       ,ExpEndPerControl       = '202104169'
WHERE ExpFormatCode = 'EHFXCENTE2';


*/




--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'EHFXCENTE2','EHFXCENTE2'
--dbo.dsi_sp_TestSwitchbox_v2 'EHFXCENTE2','TEST'

END
GO
Create View dbo.dsi_vwEHFXCENTE2_Export as
                            select top 200000000 Data from dbo.U_EHFXCENTE2_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort