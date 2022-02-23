SET NOCOUNT ON;
IF OBJECT_ID('U_ELINCTTLLC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINCTTLLC_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELINCTTLLC_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELINCTTLLC' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELINCTTLLC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELINCTTLLC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELINCTTLLC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINCTTLLC];
GO
IF OBJECT_ID('U_ELINCTTLLC_File') IS NOT NULL DROP TABLE [dbo].[U_ELINCTTLLC_File];
GO
IF OBJECT_ID('U_ELINCTTLLC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELINCTTLLC_EEList];
GO
IF OBJECT_ID('U_ELINCTTLLC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELINCTTLLC_drvTbl];
GO
IF OBJECT_ID('U_ELINCTTLLC_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELINCTTLLC_AuditFields];
GO
IF OBJECT_ID('U_ELINCTTLLC_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELINCTTLLC_Audit];
GO
IF OBJECT_ID('U_ds_ELINCTTLLC_EarnsYTD') IS NOT NULL DROP TABLE [dbo].[U_ds_ELINCTTLLC_EarnsYTD];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELINCTTLLC';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELINCTTLLC';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELINCTTLLC';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELINCTTLLC';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELINCTTLLC';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELINCTTLLC','Lincoln LFG Claims Elig','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ELINCTTLLCZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','1','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. First Name"','2','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Last Name"','3','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Middle Initial"','4','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. SSN"','5','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','5',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Gender"','6','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. DOB"','7','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','7',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation"','8','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','8',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs Per Week"','9','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','9',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Amt"','10','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Code"','11','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','11',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sal Eff Date"','12','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Addr 1"','13','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','13',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. City"','14','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. State"','15','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','15',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Zip Code"','16','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','16',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp. Zip Plus 4"','17','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','18','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','18',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','19','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','19',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Ext"','20','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','20',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','21','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp Work State"','22','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','22',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','23','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','23',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','24','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','24',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','25','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Flag"','26','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Exempt Flag"','27','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Plan Date"','28','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Eff Date"','29','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','26',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan Code"','30','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Class Code"','31','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','28',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Cvg Amount"','32','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Eff Date"','33','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','30',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Plan Code"','34','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','31',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Class Code"','35','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','32',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Cvgs"','36','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','33',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eff Date"','37','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Code"','38','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Class Code"','39','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Cvg Amount"','40','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Eff Date"','41','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Plan Code"','42','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Class Code"','43','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Cvg Amount"','44','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF VADD Option"','45','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Eff Date"','46','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Plan Code"','47','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Class Code"','48','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Cvg Amount"','49','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VSTD Elim Period"','50','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Eff Date"','51','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Plan Code"','52','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Class Code"','53','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Cvg Amount"','54','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Elim Period"','55','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Pct"','56','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Eff Date"','57','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Plan Code"','58','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Class Code"','59','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Cvgs"','60','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASO Indicator Y/N"','61','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*Claim Location Number"','62','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','39',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*Claim Location Name"','63','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*Billing Location Number"','64','(''DA''=''T,'')','ELINCTTLLCZ0','50','H','01','41',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*Billing Location Name"','65','(''DA''=''T'')','ELINCTTLLCZ0','50','H','01','42',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','1','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','1',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','2',NULL,'Emp. First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','3',NULL,'Emp. Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','4','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','4',NULL,'Emp. Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','5',NULL,'Emp. SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','6','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','6',NULL,'Emp. Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','7','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','7',NULL,'Emp. DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','8','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','8',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsPerWeek"','9','(''UNT2''=''T,'')','ELINCTTLLCZ0','50','D','10','9',NULL,'Hrs Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmt"','10','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','10',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryCode"','11','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','11',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffDate"','12','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','12',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine"','13','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','13',NULL,'Emp. Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','14','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','14',NULL,'Emp. City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','15','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','15',NULL,'Emp. State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip5"','16','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','16',NULL,'Emp. Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip4"','17','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','17',NULL,'Emp. Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','18','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','18',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','19','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','19',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','20','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','20',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','21','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','21',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','22','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','22',NULL,'Emp Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','23','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','23',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','24','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','24',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','25','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','25',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionFlag"','26','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptFlag"','27','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthPlanDate"','28','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeEffDate"','29','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','26',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlanCode"','30','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeClassCode"','31','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','28',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeCvgAmount"','32','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDEffDate"','33','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','30',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDPlanCode"','34','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','31',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDClassCode"','35','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','32',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDCvgs','36','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','33',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEffDate"','37','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDPlanCode"','38','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDClassCode"','39','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDCvgAmount"','40','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFEffDate"','41','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFPlanCode"','42','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFClassCode"','43','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFCvgAmount"','44','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFVADDOption"','45','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDEffDate"','46','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDPlanCode"','47','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDClassCode"','48','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDCvgAmount"','49','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVSTDElimPeriod"','50','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDEffDate"','51','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDPlanCode"','52','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDClassCode"','53','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDCvgAmount"','54','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDElimPeriod"','55','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDBenefitPct"','56','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTADEffDate"','57','(''UD101''=''T,'')','ELINCTTLLCZ0','50','D','10','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTADPlanCode"','58','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','35',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTADClassCode"','59','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTADCvgs','60','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASOIndicator"','61','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','38',NULL,'ASO Indicator Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimLocNum"','62','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','39',NULL,'*Claim Location Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimLocName"','63','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','40',NULL,'*Claim Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingLocNum"','64','(''UA''=''T,'')','ELINCTTLLCZ0','50','D','10','41',NULL,'*Billing Location Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingLocName"','65','(''UA''=''T'')','ELINCTTLLCZ0','50','D','10','42',NULL,'*Billing Location Name',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTTLLC_20200309.txt',NULL,'','',',UEVML',NULL,NULL,NULL,'Lincoln LFG Claims Elig','201808159','EMPEXPORT','ONDEMAND',NULL,'ELINCTTLLC',NULL,NULL,NULL,'202003039','Mar 14 2018 11:29AM','Mar 14 2018 11:29AM','202002181',NULL,'','','201808021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTTLLC_20200309.txt',NULL,NULL,NULL,',DRVFS',NULL,NULL,NULL,'Scheduled Session','201805189','EMPEXPORT','SCHEDULED',NULL,'ELINCTTLLC',NULL,NULL,NULL,'201805189','Mar 14 2018 11:29AM','Mar 14 2018 11:29AM','201805041',NULL,'','','201805041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTTLLC_20200309.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201803149','EMPEXPORT','OEACTIVE',NULL,'ELINCTTLLC',NULL,NULL,NULL,'201803149','Mar 14 2018 11:29AM','Mar 14 2018 11:29AM','201803141',NULL,'','','201803141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTTLLC_20200309.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201803149','EMPEXPORT','OEPASSIVE',NULL,'ELINCTTLLC',NULL,NULL,NULL,'201803149','Mar 14 2018 11:29AM','Mar 14 2018 11:29AM','201803141',NULL,'','','201803141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELINCTTLLC_20200309.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201906251','EMPEXPORT','TEST','Jul  1 2019 12:00AM','ELINCTTLLC',NULL,NULL,NULL,'201906251','Jun 25 2019 12:00AM','Dec 30 1899 12:00AM','201906111','1679','','','201906111',dbo.fn_GetTimedKey(),NULL,'ULTI_WPTTLLC',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELINCTTLLC_20200309.txt' END WHERE expFormatCode = 'ELINCTTLLC';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCTTLLC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCTTLLC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCTTLLC','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELINCTTLLC','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELINCTTLLC' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELINCTTLLC' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELINCTTLLC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELINCTTLLC_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINCTTLLC','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELINCTTLLC','D10','dbo.U_ELINCTTLLC_drvTbl',NULL);
IF OBJECT_ID('U_ds_ELINCTTLLC_EarnsYTD') IS NULL
CREATE TABLE [dbo].[U_ds_ELINCTTLLC_EarnsYTD] (
    [eeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [Box1] money NULL
);
IF OBJECT_ID('U_ELINCTTLLC_Audit') IS NULL
CREATE TABLE [dbo].[U_ELINCTTLLC_Audit] (
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
IF OBJECT_ID('U_ELINCTTLLC_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELINCTTLLC_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ELINCTTLLC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELINCTTLLC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvTermDate] datetime NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvOccupation] varchar(8000) NULL,
    [drvHrsPerWeek] varchar(30) NULL,
    [drvSalaryAmt] money NULL,
    [drvSalaryCode] varchar(1) NOT NULL,
    [drvSalaryEffDate] varchar(1) NOT NULL,
    [drvAddressLine] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip5] varchar(5) NULL,
    [drvAddressZip4] varchar(1) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkPhoneExt] varchar(1) NOT NULL,
    [drvDateOfHire] datetime NULL,
    [drvWorkState] varchar(1) NOT NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvRehireDate] datetime NULL,
    [drvEmail] varchar(50) NULL,
    [drvUnionFlag] varchar(1) NOT NULL,
    [drvExemptFlag] varchar(1) NOT NULL,
    [drvHealthPlanDate] varchar(1) NOT NULL,
    [drvLifeEffDate] datetime NULL,
    [drvLifePlanCode] varchar(1) NOT NULL,
    [drvLifeClassCode] varchar(1) NULL,
    [drvLifeCvgAmount] varchar(30) NULL,
    [drvSTDEffDate] varchar(1) NOT NULL,
    [drvSTDPlanCode] varchar(1) NOT NULL,
    [drvSTDClassCode] varchar(1) NOT NULL,
    [drvSTDCvgs] int NULL,
    [drvLTDEffDate] datetime NULL,
    [drvLTDPlanCode] varchar(1) NOT NULL,
    [drvLTDClassCode] varchar(1) NULL,
    [drvLTDCvgAmount] varchar(30) NULL,
    [drvVLIFEffDate] datetime NULL,
    [drvVLIFPlanCode] varchar(1) NOT NULL,
    [drvVLIFClassCode] varchar(1) NULL,
    [drvVLIFCvgAmount] varchar(30) NULL,
    [drvVLIFVADDOption] varchar(30) NULL,
    [drvVSTDEffDate] datetime NULL,
    [drvVSTDPlanCode] varchar(1) NOT NULL,
    [drvVSTDClassCode] varchar(1) NULL,
    [drvVSTDCvgAmount] varchar(30) NULL,
    [drvVSTDElimPeriod] varchar(1) NOT NULL,
    [drvVLTDEffDate] varchar(1) NOT NULL,
    [drvVLTDPlanCode] varchar(1) NOT NULL,
    [drvVLTDClassCode] varchar(1) NOT NULL,
    [drvVLTDCvgAmount] varchar(1) NOT NULL,
    [drvVLTDElimPeriod] varchar(1) NOT NULL,
    [drvVLTDBenefitPct] varchar(1) NOT NULL,
    [drvSTADEffDate] datetime NULL,
    [drvSTADPlanCode] varchar(1) NOT NULL,
    [drvSTADClassCode] varchar(1) NULL,
    [drvSTADCvgs] varchar(30) NULL,
    [drvASOIndicator] varchar(1) NOT NULL,
    [drvClaimLocNum] varchar(7) NOT NULL,
    [drvClaimLocName] varchar(3) NOT NULL,
    [drvBillingLocNum] varchar(7) NOT NULL,
    [drvBillingLocName] varchar(3) NOT NULL
);
IF OBJECT_ID('U_ELINCTTLLC_EEList') IS NULL
CREATE TABLE [dbo].[U_ELINCTTLLC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELINCTTLLC_File') IS NULL
CREATE TABLE [dbo].[U_ELINCTTLLC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELINCTTLLC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: The Tile Shop, LLC

Created By: Joseph Pham
Business Analyst: Jherilee Williams
Create Date: 5/23/2018
Service Request Number: SR-2017-00170574

Purpose: Lincoln LFG Claims Elig - This is either a general demographic file, or a portability file so that termed EEs who were covered
         can continue their LFG coverage without their employer's sponsorship.

Revision History
----------------
Update By           Date            Request Num            Desc
Sean Hawkins        04/19/2019        SR-2019-00235178    Updated for logic on ded groups and eecudfield09 for salary field
Sean Hawkins        04/29/2019                            New updates for LIFE/LTD amounts, calculcating instead of pulling
Sean Hawkins        06/06/2019                            Update for life, sal eff dates, STD fields, class codes
Sean Hawkins        06/12/2019                            Updates for amounts per testing
Sean Hawkins        06/13/2019                            Updates for part timers installed
Sean Hawkins        06/14/2019                            More updates per testing
Sean Hawkins        06/20/2019                            More updates to amounts per testing

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELINCTTLLC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELINCTTLLC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELINCTTLLC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELINCTTLLC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELINCTTLLC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCTTLLC', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCTTLLC', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCTTLLC', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELINCTTLLC', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELINCTTLLC';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELINCTTLLC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELINCTTLLC';

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
    DELETE FROM dbo.U_ELINCTTLLC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELINCTTLLC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --Clean EE list for part-timers per request, 6/13/19:
    DELETE dbo.U_ELINCTTLLC_EEList 
    FROM dbo.U_ELINCTTLLC_EEList
    JOIN dbo.EmpComp WITH (NOLOCK) on eeceeid = xeeid and eeccoid = xcoid
    WHERE  eecfulltimeorparttime = 'P';
    


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ELINCTTLLC_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCTTLLC_AuditFields;
    CREATE TABLE dbo.U_ELINCTTLLC_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELINCTTLLC_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCTTLLC_Audit;
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
    INTO dbo.U_ELINCTTLLC_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ELINCTTLLC_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELINCTTLLC_Audit ON dbo.U_ELINCTTLLC_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_ELINCTTLLC_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ELINCTTLLC_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','BLIFE,VLE,VLS,VLC,ADD,STD,LTDA,LTDE,LTDO,LTDP');
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

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --  Limit EEList to BDM only
    DELETE FROM dbo.U_ELINCTTLLC_EEList WHERE xEEID NOT IN (SELECT EedEEID FROM dbo.U_dsi_BDM_EmpDeductions WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y'); 

    --Remove Test employees
    DELETE  dbo.U_ELINCTTLLC_EEList 
    from dbo.U_ELINCTTLLC_EEList join emppers on eepeeid=xeeid where eepnamelast ='test'

    --Remove Termed employees
    DELETE  dbo.U_ELINCTTLLC_EEList 
    from dbo.U_ELINCTTLLC_EEList join empcomp on eeceeid=xeeid and eeccoid=xcoid where eecemplstatus='T'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELINCTTLLC_drvTbl
    --select drvsalaryamt,drvlifecvgamount,drvltdcvgamount,drvVLIFCvgAmount,drvVSTDCvgAmount,drvSTADCvgs  from U_ELINCTTLLC_drvTbl where drveeid in ('BW9LCO02Q0K0','BW9LTO00O0K0','BW9M730000K0') 
    --sp_geteeid '206448'
    /*
    select eeceeid
    , eecdedgroupcode
    ,eecannsalary
    ,eecudfield09
    ,case when eecdedgroupcode in ('SLS','EXEC','OPS') then isnull(NULLIF(eecudfield09,0.00), eecannsalary)
    end
    ,CAST(CEILING(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/1000.0)*1000 as money)
    from empcomp 
    where eeceeid = 'BW9LCO02Q0K0'
    select floor((ceiling (42150) + 99) / 100) * 100
    select floor(42150), ceiling(42150)
    SELECT CEILING(33281.28/1000.0) * 1000
    CAST(CEILING(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/1000.0)*1000 as money)
    */

    ---------------------------------
    IF OBJECT_ID('U_ELINCTTLLC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELINCTTLLC_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvSSN = eepSSN
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvOccupation = REPLACE(JbcLongDesc,',','')
        ,drvHrsPerWeek = CONVERT(VARCHAR,CASE
                            WHEN EmpComp.EecPayPeriod = 'W' THEN EmpComp.EecScheduledWorkHrs
                            WHEN EmpComp.EecPayPeriod = 'B' THEN EmpComp.EecScheduledWorkHrs/2
                            WHEN EmpComp.EecPayPeriod = 'S' THEN EmpComp.EecScheduledWorkHrs*24/52
                            WHEN EmpComp.EecPayPeriod = 'M' THEN EmpComp.EecSCheduledWorkHrs*12/52
                        END)
/*
in the following three deduction groups, send the benefits salary value (eecudfield09). If the benefits salary is blank or 0, then send the annual salary. 
- Sales 
- Executives and Officers 
- Operations 

If in the following two deduction groups, send the annual salary value. 
- All Others Full Time 
- Senior Professionals 
*/
        ,drvSalaryAmt = case when @ExportCode = 'TEST' and eecdedgroupcode in ('SLS','EXEC','OPS') 
                                then(case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)-- isnull(NULLIF(eecudfield09,0.00), eecannsalary)
                                when @ExportCode = 'TEST' and eecdedgroupcode in ('FT','SRP') then eecannsalary 
                                    ELSE case 
                                        when eecAnnSalary = 0 then EECUDFIELD09 
                                        else eecAnnSalary 
                                        end        --10/29/18 ISNULL(EecAnnSalary,0)
                                end
        ,drvSalaryCode = 'A'
        ,drvSalaryEffDate = ''--ISNULL((SELECT MAX(EjhJobEffDate) FROM EmpHJob WHERE EjhEEID = xEEID AND EjhCOID = XCOID AND EjhIsRateChange = 'Y'),EecDateOfLastHire)
        ,drvAddressLine = REPLACE(RTRIM(EepAddressLine1) + ' ' + RTRIM(ISNULL(EepAddressLine2,'')),',','')
        ,drvAddressCity = REPLACE(EepAddressCity,',','')
        ,drvAddressState = EepAddressState
        ,drvAddressZip5 = LEFT(EepAddressZipCode,5)
        ,drvAddressZip4 = ''
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkPhoneExt = ''
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvWorkState = '' --EecWCState
        ,drvMaritalStatus = eepMaritalStatus
        ,drvRehireDate = EecDateOfLastHire
        ,drvEmail = EepAddressEMail
        ,drvUnionFlag = ''
        ,drvExemptFlag = ''
        ,drvHealthPlanDate = ''

        ,drvLifeEffDate = IIF(Life.EedEEID IS NOT NULL, Life.EedBenStartDate, NULL)
        ,drvLifePlanCode = IIF(Life.EedEEID IS NOT NULL,'1','')
        --select distinct eecdedgroupcode from empcomp
        --select * from bengrp
        ,drvLifeClassCode = CASE WHEN Life.EedEEID IS NOT NULL 
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            --ELSE '5'--all others
                            END--IIF(Life.EedEEID IS NOT NULL,'1','')
        ,drvLifeCvgAmount = case when @ExportCode = 'TEST' --set to 280000.00 max amount
                    and CAST(CEILING((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/1000.0)*1000 as money) >= 280000.00
                    then '280000.00'
                    
                    when @ExportCode = 'TEST' 
                    and CAST(CEILING((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/1000.0)*1000 as money) < 280000.00
                    then CAST(CAST(CEILING((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/1000.0)*1000 as money) as varchar)
                    
                    else NULL
                end

        ,drvSTDEffDate = ''--IIF(STD.EedEEID IS NOT NULL, STD.EedBenStartDate, NULL)
        ,drvSTDPlanCode = ''--IIF(STD.EedEEID IS NOT NULL,'1','')
        ,drvSTDClassCode = ''--IIF(STD.EedEEID IS NOT NULL,'1','')
        ,drvSTDCvgs = NULL--IIF(STD.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(STD.BcaBenAmtCalc,0) as MONEY)), NULL)

        ,drvLTDEffDate = IIF(LTD.EedEEID IS NOT NULL, LTD.EedBenStartDate, NULL)
        ,drvLTDPlanCode = IIF(LTD.EedEEID IS NOT NULL, '1', '')
        ,drvLTDClassCode =  CASE WHEN LTD.EedEEID IS NOT NULL --IIF(LTD.EedEEID IS NOT NULL, '1', '')
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            
                            END
         /*,drvLTDCvgAmount =case when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and (eecannsalary)/12 *.60 < 1500.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)-- isnull(eecudfield09, eecannsalary)/12 *.60 -- CONVERT(VARCHAR,CAST(ISNULL(isnull(eecudfield09, eecannsalary)/12 *.60,0)as money),NULL)
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and (eecannsalary)/12 *.60 >= 1500.00 then '1500.00'
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and (eecannsalary)/12 *.60 < 6000.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and (eecannsalary)/12 *.60 >= 6000.00 then '6000.00'
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and (eecannsalary)/12 *.60 < 4500.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and (eecannsalary)/12 *.60 >= 4500.00 then '4500.00'
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and (eecannsalary)/12 *.60 < 1500.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and (eecannsalary)/12 *.60 >= 1500.00 then '1500.00'
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and (eecannsalary)/12 *.60 < 3000.00 then 
                CAST(CAST(eecannsalary/12 *.60 as money) as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and (eecannsalary)/12 *.60 >= 3000.00 then '3000.00'
                else '0.00'
                END
                --removed 6/14/19:
                */
        ,drvLTDCvgAmount = case when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 1500.00 
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 1500.00 then '1500.00'

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 6000.00  
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 6000.00 then '6000.00'

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 4500.00 
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)

                
                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 4500.00 then '4500.00'

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 1500.00  
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 1500.00 then '1500.00'

                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 < 3000.00  
                    THEN CAST(CONVERT(VARCHAR,CAST(ISNULL((case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60,0) as MONEY))as varchar)--isnull(eecudfield09, eecannsalary)/12 *.60 
                
                    when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and 
                    (case when isnull(eecudfield09,0.00) > eecannsalary then eecudfield09 else eecannsalary end)/12 *.60 >= 3000.00 then '3000.00'
                                    
            else '0.00'
        END
                --IIF(LTD.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(LTD.BcaBenAmtCalc,0) as MONEY)), NULL)
        /*case when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 1500.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))-- isnull(eecudfield09, eecannsalary)/12 *.60 -- CONVERT(VARCHAR,CAST(ISNULL(isnull(eecudfield09, eecannsalary)/12 *.60,0)as money),NULL)
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SLS') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 1500.00 then 1500.00
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 6000.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('EXEC') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 6000.00 then 6000.00
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 4500.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('OPS') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 4500.00 then 4500.00
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 1500.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('FT') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 1500.00 then 1500.00
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 < 3000.00 then CONVERT(VARCHAR,CAST(ISNULL(isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60,0) as MONEY))--isnull(eecudfield09, eecannsalary)/12 *.60 
                when @ExportCode = 'TEST' and LTD.EedEEID IS NOT NULL and eecdedgroupcode in ('SRP') and isnull(NULLIF(eecudfield09,0.00), eecannsalary)/12 *.60 >= 3000.00 then 3000.00
                else 0.00
                END*/
                --IIF(LTD.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(LTD.BcaBenAmtCalc,0) as MONEY)), NULL)
        ,drvVLIFEffDate = IIF(VLIFEE.EedEEID IS NOT NULL, VLIFEE.EedBenStartDate, NULL)
        ,drvVLIFPlanCode = IIF(VLIFEE.EedEEID IS NOT NULL, '1', '')
        ,drvVLIFClassCode = CASE WHEN VLIFEE.EedEEID IS NOT NULL 
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            
                            END--IIF(VLIFEE.EedEEID IS NOT NULL, '1', '')
        ,drvVLIFCvgAmount = IIF(VLIFEE.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(VLIFEE.BcaBenAmtCalc,0) as MONEY)), NULL)
        ,drvVLIFVADDOption = IIF(VLIFEE.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(ADnD.BcaBenAmtCalc,0) as MONEY)), NULL)
        ,drvVSTDEffDate = IIF(STD.EedEEID IS NOT NULL, STD.EedBenStartDate, NULL)--''
        ,drvVSTDPlanCode = IIF(STD.EedEEID IS NOT NULL,'1','')--''
        ,drvVSTDClassCode = CASE WHEN STD.EedEEID IS NOT NULL --IIF(LTD.EedEEID IS NOT NULL, '1', '')
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            
                            END--IIF(VLIFEE.EedEEID IS NOT NULL, '1', '')--IIF(STD.EedEEID IS NOT NULL,'1','')--''
        ,drvVSTDCvgAmount = IIF(STD.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(STD.BcaBenAmtCalc,0) as MONEY)), NULL)--''
        ,drvVSTDElimPeriod = ''
        ,drvVLTDEffDate = ''
        ,drvVLTDPlanCode = ''
        ,drvVLTDClassCode = ''
        ,drvVLTDCvgAmount = ''
        ,drvVLTDElimPeriod = ''
        ,drvVLTDBenefitPct = ''
        ,drvSTADEffDate = IIF(ADnD.EedEEID IS NOT NULL, ADnD.EedBenStartDate, NULL)
        ,drvSTADPlanCode = IIF(ADnD.EedEEID IS NOT NULL, '1', '')
        ,drvSTADClassCode = CASE WHEN ADnD.EedEEID IS NOT NULL --IIF(LTD.EedEEID IS NOT NULL, '1', '')
                            then case eecdedgroupcode
                                WHEN 'EXEC' then '1'
                                WHEN 'OPS' then '2'
                                WHEN 'SRP' then '3'
                                WHEN 'SLS' then '4'
                                WHEN 'FT' then '5'
                                END
                            
                            END--IIF(ADnD.EedEEID IS NOT NULL, '1', '')
        ,drvSTADCvgs = IIF(ADnD.EedEEID IS NOT NULL, CONVERT(VARCHAR,CAST(ISNULL(ADnD.BcaBenAmtCalc,0) as MONEY)), NULL)

        ,drvASOIndicator = 'N'

        ,drvClaimLocNum = '2788674'
        ,drvClaimLocName = 'N/A'
        ,drvBillingLocNum = '1570606'
        ,drvBillingLocName = 'N/A'

    INTO dbo.U_ELINCTTLLC_drvTbl
    
    FROM dbo.U_ELINCTTLLC_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecPayGroup = 'SEMIMO'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('BLIFE')) Life
        ON Life.EedEEID = xEEID 
        AND Life.EedCoID = xCoID
        
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('VLE')) VLIFEE
        ON VLIFEE.EedEEID = xEEID 
        AND VLIFEE.EedCoID = xCoID
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('STD')) STD
        ON STD.EedEEID = xEEID 
        AND STD.EedCoID = xCoID
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('LTDA','LTDE','LTDO','LTDP')) LTD
        ON LTD.EedEEID = xEEID 
        AND LTD.EedCoID = xCoID
    LEFT JOIN (SELECT * FROM dbo.U_dsi_BDM_EmpDeductions
                        JOIN dbo.u_dsi_bdm_BenCalculationAmounts
                            on eedeeid = bcaeeid
                            and eedcoid = bcacoid
                            and eedFormatCode = bcaFormatCode
                            and eeddedcode = bcadedcode
                        WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'Y' AND EedDedCode IN ('ADD')) ADnD
        ON ADnD.EedEEID = xEEID 
        AND ADnD.EedCoID = xCoID

    LEFT JOIN dbo.U_ds_ELINCTTLLC_EarnsYTD
        ON eeid = xEEID
        AND ecoid = xCOID

    ;
    
    --==========================================
    -- Set FileName
    --==========================================
    --IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    --BEGIN
    --    UPDATE dbo.U_dsi_Parameters
    --        SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_ELINCTTLLC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              WHEN @ExportCode LIKE 'OE%' THEN 'OE_ELINCTTLLC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                              ELSE 'ELINCTTLLC_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
    --                         END
    --    WHERE FormatCode = @FormatCode;
    --END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwELINCTTLLC_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ELINCTTLLC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELINCTTLLC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201803071'
       ,expStartPerControl     = '201803071'
       ,expLastEndPerControl   = '201803149'
       ,expEndPerControl       = '201803149'
WHERE expFormatCode = 'ELINCTTLLC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELINCTTLLC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELINCTTLLC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort