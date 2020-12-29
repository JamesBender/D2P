SET NOCOUNT ON;
IF OBJECT_ID('U_EVOYAEOIEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOYAEOIEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EVOYAEOIEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EVOYAEOIEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEVOYAEOIEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVOYAEOIEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVOYAEOIEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOYAEOIEX];
GO
IF OBJECT_ID('U_EVOYAEOIEX_File') IS NOT NULL DROP TABLE [dbo].[U_EVOYAEOIEX_File];
GO
IF OBJECT_ID('U_EVOYAEOIEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVOYAEOIEX_EEList];
GO
IF OBJECT_ID('U_EVOYAEOIEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVOYAEOIEX_drvTbl];
GO
IF OBJECT_ID('U_EVOYAEOIEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EVOYAEOIEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EVOYAEOIEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EVOYAEOIEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EVOYAEOIEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EVOYAEOIEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EVOYAEOIEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EVOYAEOIEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EVOYAEOIEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EVOYAEOIEX','Voya EOI Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EVOYAEOIEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EVOYAEOIEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group Number"','1','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','1',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Number"','2','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','2',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EOI Mail Location"','3','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','3',NULL,'EOI Mail Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s SSN / Spouse s SSN"','4','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','4',NULL,'Employee s SSN / Spouse s SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Name - First"','5','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','5',NULL,'Employee s Name - First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Name - Middle Initial"','6','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','6',NULL,'Employee s Name - Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Name - Last"','7','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','7',NULL,'Employee s Name - Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Date of Birth"','8','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','8',NULL,'Employee s Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Gender"','9','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','9',NULL,'Employee s Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Hire Date (Fulltime)"','10','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','10',NULL,'Employee s Hire Date (Fulltime)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Job Title"','11','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','11',NULL,'Employee s Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','12','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','12',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Annual Salary"','13','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','13',NULL,'Employee s Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Country"','14','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','14',NULL,'Employee s Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Home Address Line 1"','15','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','15',NULL,'Employee s Home Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Home Address Line 2"','16','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','16',NULL,'Employee s Home Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s City"','17','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','17',NULL,'Employee s City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s  State/Province"','18','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','18',NULL,'Employee s  State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Zip/Postal Code"','19','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','19',NULL,'Employee s Zip/Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Home Phone"','20','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','20',NULL,'Employee s Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Cell Phone"','21','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','21',NULL,'Employee s Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee s Email Address"','22','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','22',NULL,'Employee s Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Basic Life"','23','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','23',NULL,'EE - Basic Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Total Amt Desired"','24','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','24',NULL,'EE - Total Amt Desired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Current Amount"','25','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','25',NULL,'EE - Current Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Guaranteed Issue Amount"','26','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','26',NULL,'EE - Guaranteed Issue Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Amt to be UW"','27','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','27',NULL,'EE - Amt to be UW',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Supplemental Life"','28','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','28',NULL,'EE - Supplemental Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Total Amt Desired"','29','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','29',NULL,'EE - Total Amt Desired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Current Amount"','30','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','30',NULL,'EE - Current Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Guaranteed Issue Amount"','31','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','31',NULL,'EE - Guaranteed Issue Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - Amt to be UW"','32','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','32',NULL,'EE - Amt to be UW',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - LTD"','33','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','33',NULL,'EE - LTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE - STD"','34','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','34',NULL,'EE - STD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Basic Life"','35','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','35',NULL,'SP - Basic Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Total Amt Desired"','36','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','36',NULL,'SP - Total Amt Desired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Current Amount"','37','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','37',NULL,'SP - Current Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Guaranteed Issue Amount"','38','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','38',NULL,'SP - Guaranteed Issue Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Amt to be UW"','39','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','39',NULL,'SP - Amt to be UW',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Supplemental Life"','40','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','40',NULL,'SP - Supplemental Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Total Amt Desired"','41','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','41',NULL,'SP - Total Amt Desired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Current Amount"','42','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','42',NULL,'SP - Current Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Guaranteed Issue Amount"','43','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','43',NULL,'SP - Guaranteed Issue Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP - Amt to be UW"','44','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','44',NULL,'SP - Amt to be UW',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse s Name - First"','45','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','45',NULL,'Spouse s Name - First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse s Name - Middle Initial"','46','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','46',NULL,'Spouse s Name - Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse s Name - Last"','47','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','47',NULL,'Spouse s Name - Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse s Relationship to Employee"','48','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','48',NULL,'Spouse s Relationship to Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse s Date of Birth"','49','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','49',NULL,'Spouse s Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse s SSN"','50','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','50',NULL,'Spouse s SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse s Gender"','51','(''DA''=''T,'')','EVOYAEOIEXZ0','50','H','01','51',NULL,'Spouse s Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse s Email Address"','52','(''DA''=''T'')','EVOYAEOIEXZ0','50','H','01','52',NULL,'Spouse s Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00717614"','1','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','1',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','2',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"All"','3','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','3',NULL,'EOI Mail Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','4',NULL,'Employee s SSN / Spouse s SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','5',NULL,'Employee s Name - First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','6',NULL,'Employee s Name - Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','7',NULL,'Employee s Name - Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','8','(''UD101''=''T,'')','EVOYAEOIEXZ0','50','D','10','8',NULL,'Employee s Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','9',NULL,'Employee s Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','10','(''UD101''=''T,'')','EVOYAEOIEXZ0','50','D','10','10',NULL,'Employee s Hire Date (Fulltime)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','11','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','11',NULL,'Employee s Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','12','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','12',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','13','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','13',NULL,'Employee s Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','14','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','14',NULL,'Employee s Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','15','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','15',NULL,'Employee s Home Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','16','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','16',NULL,'Employee s Home Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','17',NULL,'Employee s City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','18',NULL,'Employee s  State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','19',NULL,'Employee s Zip/Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeHomePhone"','20','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','20',NULL,'Employee s Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeCellPhone"','21','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','21',NULL,'Employee s Cell Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEmailAddress"','22','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','22',NULL,'Employee s Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','23',NULL,'EE - Basic Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','24',NULL,'EE - Total Amt Desired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','25',NULL,'EE - Current Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','26',NULL,'EE - Guaranteed Issue Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','27',NULL,'EE - Amt to be UW',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEESupplementalLife"','28','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','28',NULL,'EE - Supplemental Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETotalAmountDesired"','29','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','29',NULL,'EE - Total Amt Desired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drcEECurrentAmount"','30','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','30',NULL,'EE - Current Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEGuarIssedAmount"','31','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','31',NULL,'EE - Guaranteed Issue Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEAmtToBeUW"','32','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','32',NULL,'EE - Amt to be UW',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','33',NULL,'EE - LTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','34',NULL,'EE - STD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','35',NULL,'SP - Basic Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','36',NULL,'SP - Total Amt Desired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','37',NULL,'SP - Current Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','38',NULL,'SP - Guaranteed Issue Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T,'')','EVOYAEOIEXZ0','50','D','10','39',NULL,'SP - Amt to be UW',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPSupplementalLife"','40','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','40',NULL,'SP - Supplemental Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPTotalAmountDesired"','41','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','41',NULL,'SP - Total Amt Desired',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCurrentAmount"','42','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','42',NULL,'SP - Current Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPGuarIssueAmount"','43','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','43',NULL,'SP - Guaranteed Issue Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPAmtToBeUW"','44','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','44',NULL,'SP - Amt to be UW',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameFirst"','45','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','45',NULL,'Spouse s Name - First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameMiddle"','46','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','46',NULL,'Spouse s Name - Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameLast"','47','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','47',NULL,'Spouse s Name - Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipToEmployee"','48','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','48',NULL,'Spouse s Relationship to Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDateOfBirth"','49','(''UD101''=''T,'')','EVOYAEOIEXZ0','50','D','10','49',NULL,'Spouse s Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSSN"','50','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','50',NULL,'Spouse s SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','51','(''UA''=''T,'')','EVOYAEOIEXZ0','50','D','10','51',NULL,'Spouse s Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseEmailAddress"','52','(''UA''=''T'')','EVOYAEOIEXZ0','50','D','10','52',NULL,'Spouse s Email Address',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EVOYAEOIEX_20201214.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202012149','EMPEXPORT','OEACTIVE',NULL,'EVOYAEOIEX',NULL,NULL,NULL,'202012149','Dec 14 2020  4:04PM','Dec 14 2020  4:04PM','202012141',NULL,'','','202012141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202012149','EMPEXPORT','OEPASSIVE',NULL,'EVOYAEOIEX',NULL,NULL,NULL,'202012149','Dec 14 2020  4:04PM','Dec 14 2020  4:04PM','202012141',NULL,'','','202012141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya EOI Export','202012149','EMPEXPORT','ONDEM_XOE',NULL,'EVOYAEOIEX',NULL,NULL,NULL,'202012149','Dec 14 2020  4:04PM','Dec 14 2020  4:04PM','202012141',NULL,'','','202012141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya EOI Export-Sched','202012149','EMPEXPORT','SCH_EVOYAE',NULL,'EVOYAEOIEX',NULL,NULL,NULL,'202012149','Dec 14 2020  4:04PM','Dec 14 2020  4:04PM','202012141',NULL,'','','202012141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Voya EOI Export-Test','202012149','EMPEXPORT','TEST_XOE',NULL,'EVOYAEOIEX',NULL,NULL,NULL,'202012149','Dec 14 2020  4:04PM','Dec 14 2020  4:04PM','202012141',NULL,'','','202012141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYAEOIEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYAEOIEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYAEOIEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYAEOIEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYAEOIEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EVOYAEOIEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EVOYAEOIEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EVOYAEOIEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOYAEOIEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOYAEOIEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOYAEOIEX','D10','dbo.U_EVOYAEOIEX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EVOYAEOIEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EVOYAEOIEX] (
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
IF OBJECT_ID('U_EVOYAEOIEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EVOYAEOIEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EVOYAEOIEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVOYAEOIEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvHireDate] datetime NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvAnnualSalary] nvarchar(4000) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvEmployeeHomePhone] varchar(50) NULL,
    [drvEmployeeCellPhone] varchar(50) NULL,
    [drvEmployeeEmailAddress] varchar(50) NULL,
    [drvEESupplementalLife] varchar(1) NOT NULL,
    [drvEETotalAmountDesired] nvarchar(4000) NULL,
    [drcEECurrentAmount] nvarchar(4000) NULL,
    [drvEEGuarIssedAmount] nvarchar(4000) NULL,
    [drvEEAmtToBeUW] nvarchar(4000) NULL,
    [drvSPSupplementalLife] varchar(1) NOT NULL,
    [drvSPTotalAmountDesired] nvarchar(4000) NULL,
    [drvSPCurrentAmount] nvarchar(4000) NULL,
    [drvSPGuarIssueAmount] nvarchar(4000) NULL,
    [drvSPAmtToBeUW] nvarchar(4000) NULL,
    [drvSpouseNameFirst] varchar(100) NULL,
    [drvSpouseNameMiddle] varchar(1) NULL,
    [drvSpouseNameLast] varchar(100) NULL,
    [drvRelationshipToEmployee] varchar(16) NULL,
    [drvSpouseDateOfBirth] datetime NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvSpouseGender] varchar(1) NULL,
    [drvSpouseEmailAddress] varchar(50) NULL
);
IF OBJECT_ID('U_EVOYAEOIEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EVOYAEOIEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EVOYAEOIEX_File') IS NULL
CREATE TABLE [dbo].[U_EVOYAEOIEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOYAEOIEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PowerSchool

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 12/14/2020
Service Request Number: TekP-2020-10-21-0005

Purpose: Voya EOI Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVOYAEOIEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVOYAEOIEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVOYAEOIEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVOYAEOIEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVOYAEOIEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYAEOIEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYAEOIEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYAEOIEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYAEOIEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYAEOIEX', 'SCH_EVOYAE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EVOYAEOIEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EVOYAEOIEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EVOYAEOIEX';

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
    DELETE FROM dbo.U_EVOYAEOIEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVOYAEOIEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EVOYAEOIEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    )
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'USESL,USSL';

    IF OBJECT_ID('U_EVOYAEOIEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYAEOIEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVOYAEOIEX_DedList
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

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EVOYAEOIEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVOYAEOIEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYAEOIEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '' --CAST(EecAnnSalary AS VARCHAR)
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'M' END
        ,drvHireDate = EecDateOfLastHire
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvEmployeeID = EecEmpNo
        ,drvAnnualSalary = FORMAT(EecAnnSalary, '#0')
        ,drvAddressCountry = EepAddressCountry
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvEmployeeHomePhone = EepPhoneHomeNumber
        ,drvEmployeeCellPhone = efoPhoneNumber
        ,drvEmployeeEmailAddress = EepAddressEMail
        ,drvEESupplementalLife =    CASE WHEN USESL_DedCode IS NOT NULL AND ISNULL(USESL_EedNeedEOI, '') = 'Y' THEN 'Y' 
                                        WHEN USESL_DedCode IS NOT NULL AND USESL_EedEOIDesiredAmt > 200000 THEN 'Y'
                                        ELSE 'N'
                                    END
        ,drvEETotalAmountDesired = FORMAT(CASE WHEN USESL_DedCode IS NOT NULL THEN USESL_EedEOIDesiredAmt END, '#0')
        ,drcEECurrentAmount = FORMAT(CASE WHEN USESL_DedCode IS NOT NULL THEN USESL_EedBenAmt END, '#0')
        ,drvEEGuarIssedAmount = FORMAT(CASE WHEN USESL_DedCode IS NOT NULL AND USESL_EedEOIDesiredAmt > 200000 THEN 200000 ELSE USESL_EedBenAmt END, '#0')
        ,drvEEAmtToBeUW = CASE WHEN USESL_DedCode IS NOT NULL AND (USESL_EedEOIDesiredAmt - USESL_EedBenAmt) > 0 THEN FORMAT(USESL_EedEOIDesiredAmt - USESL_EedBenAmt, '#0') END
        ,drvSPSupplementalLife =    CASE WHEN USSL_DedCode IS NOT NULL AND ISNULL(USSL_EedNeedEOI, '') = 'Y' THEN 'Y' 
                                        WHEN USSL_DedCode IS NOT NULL AND USSL_EedEOIDesiredAmt > 25000 THEN 'Y'
                                        ELSE 'N'
                                    END
        ,drvSPTotalAmountDesired = FORMAT(CASE WHEN USSL_DedCode IS NOT NULL THEN USSL_EedEOIDesiredAmt END, '#0')
        ,drvSPCurrentAmount = FORMAT(CASE WHEN USSL_DedCode IS NOT NULL THEN USSL_EedBenAmt END, '#0')
        ,drvSPGuarIssueAmount = FORMAT(CASE WHEN USSL_DedCode IS NOT NULL AND USSL_EedEOIDesiredAmt > 200000 THEN 200000 ELSE USSL_EedBenAmt END, '#0')
        ,drvSPAmtToBeUW = CASE WHEN USSL_DedCode IS NOT NULL AND (USSL_EedEOIDesiredAmt - USSL_EedBenAmt) > 0 THEN FORMAT(USSL_EedEOIDesiredAmt - USSL_EedBenAmt, '#0') END
        ,drvSpouseNameFirst = CASE WHEN USSL_DedCode IS NOT NULL AND (ISNULL(USSL_EedNeedEOI, '') = 'Y' OR USSL_EedEOIDesiredAmt > 25000) THEN ConNameFirst END
        ,drvSpouseNameMiddle = CASE WHEN USSL_DedCode IS NOT NULL AND (ISNULL(USSL_EedNeedEOI, '') = 'Y' OR USSL_EedEOIDesiredAmt > 25000) THEN LEFT(ConNameMiddle,1) END
        ,drvSpouseNameLast = CASE WHEN USSL_DedCode IS NOT NULL AND (ISNULL(USSL_EedNeedEOI, '') = 'Y' OR USSL_EedEOIDesiredAmt > 25000) THEN ConNameLast END
        ,drvRelationshipToEmployee = CASE WHEN USSL_DedCode IS NOT NULL AND ConRelationship = 'DP' AND (ISNULL(USSL_EedNeedEOI, '') = 'Y' OR USSL_EedEOIDesiredAmt > 25000) THEN 'Domestic Partner' END
        ,drvSpouseDateOfBirth = CASE WHEN USSL_DedCode IS NOT NULL AND (ISNULL(USSL_EedNeedEOI, '') = 'Y' OR USSL_EedEOIDesiredAmt > 25000) THEN ConDateOfBirth END
        ,drvSpouseSSN = CASE WHEN USSL_DedCode IS NOT NULL AND (ISNULL(USSL_EedNeedEOI, '') = 'Y' OR USSL_EedEOIDesiredAmt > 25000) THEN ConSSN END
        ,drvSpouseGender =    CASE WHEN USSL_DedCode IS NOT NULL AND (ISNULL(USSL_EedNeedEOI, '') = 'Y' OR USSL_EedEOIDesiredAmt > 25000) THEN
                                CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'M' END
                            END
        ,drvSpouseEmailAddress = CASE WHEN USSL_DedCode IS NOT NULL AND (ISNULL(USSL_EedNeedEOI, '') = 'Y' OR USSL_EedEOIDesiredAmt > 25000) THEN ConEmailAddr END
    INTO dbo.U_EVOYAEOIEX_drvTbl
    FROM dbo.U_EVOYAEOIEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
--    JOIN dbo.U_dsi_BDM_EVOYAEOIEX WITH (NOLOCK)
    JOIN (
            SELECT BdmEEID, BdmCOID    
                ,MAX(CASE WHEN BdmDedCode = 'USESL' THEN BdmDedCode END) AS USESL_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'USSL' THEN BdmDedCode END) AS USSL_DedCode
            FROM dbo.U_dsi_BDM_EVOYAEOIEX WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
--        AND ConSystemID = BdmDepRecID
        AND ConRelationship IN ('DP','SPS')
        AND ConIsBeneficiary = 'Y'
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON EfoEEID = xEEID
        AND efoPhoneType = 'CEL'
    JOIN (
            SELECT EedEEID, EedCOID
                ,MAX(CASE WHEN EedDedCode = 'USESL' THEN EedEOIDesiredAmt ELSE 0.00 END) AS USESL_EedEOIDesiredAmt
                ,MAX(CASE WHEN EedDedCode = 'USESL' THEN EedBenAmt ELSE 0.00 END) AS USESL_EedBenAmt
                ,MAX(CASE WHEN EedDedCode = 'USESL' THEN EedNeedEOI END) AS USESL_EedNeedEOI
                ,MAX(CASE WHEN EedDedCode = 'USSL' THEN EedEOIDesiredAmt ELSE 0.00 END) AS USSL_EedEOIDesiredAmt
                ,MAX(CASE WHEN EedDedCode = 'USSL' THEN EedBenAmt ELSE 0.00 END) AS USSL_EedBenAmt
                ,MAX(CASE WHEN EedDedCode = 'USSL' THEN EedNeedEOI END) AS USSL_EedNeedEOI
            FROM dbo.EmpDed WITH (NOLOCK)
            GROUP BY EedEEID, EedCOID) AS EED
        ON EedEEID = xEEID
        AND EecCOID = xCOID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
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
ALTER VIEW dbo.dsi_vwEVOYAEOIEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVOYAEOIEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EVOYAEOIEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202012071'
       ,expStartPerControl     = '202012071'
       ,expLastEndPerControl   = '202012149'
       ,expEndPerControl       = '202012149'
WHERE expFormatCode = 'EVOYAEOIEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEVOYAEOIEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EVOYAEOIEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort