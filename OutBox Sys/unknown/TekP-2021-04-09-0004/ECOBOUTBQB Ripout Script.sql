SET NOCOUNT ON;
IF OBJECT_ID('U_ECOBOUTBQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBOUTBQB_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECOBOUTBQB_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECOBOUTBQB' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECOBOUTBQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECOBOUTBQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOBOUTBQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBOUTBQB];
GO
IF OBJECT_ID('U_ECOBOUTBQB_File') IS NOT NULL DROP TABLE [dbo].[U_ECOBOUTBQB_File];
GO
IF OBJECT_ID('U_ECOBOUTBQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECOBOUTBQB_EEList];
GO
IF OBJECT_ID('U_ECOBOUTBQB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECOBOUTBQB_drvTbl];
GO
IF OBJECT_ID('U_dsi_ECOBOUTBQB_depTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBOUTBQB_depTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECOBOUTBQB';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECOBOUTBQB';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECOBOUTBQB';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECOBOUTBQB';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECOBOUTBQB';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECOBOUTBQB','My Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','ECOBOUTBQBZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECOBOUTBQB' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client ID"','1','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','1',NULL,'Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','2','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','2',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security #"','3','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','3',NULL,'Social Security #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','4','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','5','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address"','6','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','6',NULL,'Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City "','7','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','7',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','8','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','8',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','9','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','9',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sex"','10','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','10',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','11','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','11',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status *"','12','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','12',NULL,'Marital Status *',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Coverage effective Date"','13','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','13',NULL,'Original Coverage effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Event Type *"','14','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','14',NULL,'Event Type *',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Event Date"','15','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','15',NULL,'Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EAP Plan? Y/N"','16','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','16',NULL,'EAP Plan? Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Flexible Spending? Y/N"','17','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','17',NULL,'Flexible Spending? Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Flexible Spending Monthly $ Amount:"','18','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','18',NULL,'Flexible Spending Monthly $ Amount:',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Medical Carrier/Plan Name"','19','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','19',NULL,'Medical Carrier/Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Level of Coverage*"','20','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','20',NULL,'Level of Coverage*',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Age Rate Amount $"','21','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','21',NULL,'Age Rate Amount $',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dental Carrier/Plan Name"','22','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','22',NULL,'Dental Carrier/Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Level of Coverage*"','23','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','23',NULL,'Level of Coverage*',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Vision Carrier/Plan Name"','24','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','24',NULL,'Vision Carrier/Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Level of Coverage*"','25','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','25',NULL,'Level of Coverage*',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Pay for COBRA - Amount to Pay"','26','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','26',NULL,'Employer Pay for COBRA - Amount to Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"What Coverage"','27','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','27',NULL,'What Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"How Long"','28','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','28',NULL,'How Long',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent 1 Last Name"','29','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','29',NULL,'Dependent 1 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','30','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','30',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','31','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','31',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','32','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','32',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent 2 Last Name"','33','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','33',NULL,'Dependent 2 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','34','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','34',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','35','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','35',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','36','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','36',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent 3 Last Name"','37','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','37',NULL,'Dependent 3 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','38','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','38',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','39','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','39',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','40','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','40',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent 4 Last Name"','41','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','41',NULL,'Dependent 4 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','42','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','42',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','43','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','43',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','44','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','44',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent 5 Last Name"','45','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','45',NULL,'Dependent 5 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','46','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','46',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','47','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','47',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','48','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','48',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent 6 Last Name"','49','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','49',NULL,'Dependent 6 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','50','(''DA''=''T,'')','ECOBOUTBQBZ0','50','H','01','50',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','51','(''DA''=''T,'')','ECOBOUTBQBZ0','51','H','01','51',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','52','(''DA''=''T,'')','ECOBOUTBQBZ0','52','H','01','52',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent 7 Last Name"','53','(''DA''=''T,'')','ECOBOUTBQBZ0','53','H','01','53',NULL,'Dependent 7 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','54','(''DA''=''T,'')','ECOBOUTBQBZ0','54','H','01','54',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','55','(''DA''=''T,'')','ECOBOUTBQBZ0','55','H','01','55',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','56','(''DA''=''T'')','ECOBOUTBQBZ0','56','H','01','56',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientID"','1','(''UA''=''T,'')','ECOBOUTBQBZ0','57','D','10','1',NULL,'Client ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','2','(''UA''=''T,'')','ECOBOUTBQBZ0','58','D','10','2',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurity"','3','(''UA''=''T,'')','ECOBOUTBQBZ0','59','D','10','3',NULL,'Social Security #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','4','(''UA''=''T,'')','ECOBOUTBQBZ0','60','D','10','4',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''T,'')','ECOBOUTBQBZ0','61','D','10','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress"','6','(''UA''=''T,'')','ECOBOUTBQBZ0','62','D','10','6',NULL,'Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','7','(''UA''=''T,'')','ECOBOUTBQBZ0','63','D','10','7',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','8','(''UA''=''T,'')','ECOBOUTBQBZ0','64','D','10','8',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','9','(''UA''=''T,'')','ECOBOUTBQBZ0','65','D','10','9',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','10','(''UA''=''T,'')','ECOBOUTBQBZ0','66','D','10','10',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','11','(''UA''=''T,'')','ECOBOUTBQBZ0','67','D','10','11',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','12','(''UA''=''T,'')','ECOBOUTBQBZ0','68','D','10','12',NULL,'Marital Status *',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalCoverageEffDate"','13','(''UD101''=''T,'')','ECOBOUTBQBZ0','69','D','10','13',NULL,'Original Coverage effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','14','(''UA''=''T,'')','ECOBOUTBQBZ0','70','D','10','14',NULL,'Event Type *',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','15','(''UD101''=''T,'')','ECOBOUTBQBZ0','71','D','10','15',NULL,'Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEAPPlan"','16','(''UA''=''T,'')','ECOBOUTBQBZ0','72','D','10','16',NULL,'EAP Plan? Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFlexibleSpending"','17','(''UA''=''T,'')','ECOBOUTBQBZ0','73','D','10','17',NULL,'Flexible Spending? Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAMonthlyAmount"','18','(''UA''=''T,'')','ECOBOUTBQBZ0','74','D','10','18',NULL,'Flexible Spending Monthly $ Amount:',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicalCarrierPlanName"','19','(''UA''=''T,'')','ECOBOUTBQBZ0','75','D','10','19',NULL,'Medical Carrier/Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEDLevelofCoverage"','20','(''UA''=''T,'')','ECOBOUTBQBZ0','76','D','10','20',NULL,'Level of Coverage*',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAgeRateAmount"','21','(''UA''=''T,'')','ECOBOUTBQBZ0','77','D','10','21',NULL,'Age Rate Amount $',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentalCarrierPlanName"','22','(''UA''=''T,'')','ECOBOUTBQBZ0','78','D','10','22',NULL,'Dental Carrier/Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDENLevelofCoverage"','23','(''UA''=''T,'')','ECOBOUTBQBZ0','79','D','10','23',NULL,'Level of Coverage*',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVisionCarrierPlanName"','24','(''UA''=''T,'')','ECOBOUTBQBZ0','80','D','10','24',NULL,'Vision Carrier/Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVISLevelofCoverage"','25','(''UA''=''T,'')','ECOBOUTBQBZ0','81','D','10','25',NULL,'Level of Coverage*',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerPayforCOBRA"','26','(''UA''=''T,'')','ECOBOUTBQBZ0','82','D','10','26',NULL,'Employer Pay for COBRA - Amount to Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWhatCoverage"','27','(''UA''=''T,'')','ECOBOUTBQBZ0','83','D','10','27',NULL,'What Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHowLong"','28','(''UA''=''T,'')','ECOBOUTBQBZ0','84','D','10','28',NULL,'How Long',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1LastName"','29','(''UA''=''T,'')','ECOBOUTBQBZ0','85','D','10','29',NULL,'Dependent 1 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1FirstName"','30','(''UA''=''T,'')','ECOBOUTBQBZ0','86','D','10','30',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1Relationship"','31','(''UA''=''T,'')','ECOBOUTBQBZ0','87','D','10','31',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1DOB"','32','(''UA''=''T,'')','ECOBOUTBQBZ0','88','D','10','32',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2LastName"','33','(''UA''=''T,'')','ECOBOUTBQBZ0','89','D','10','33',NULL,'Dependent 2 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2FirstName"','34','(''UA''=''T,'')','ECOBOUTBQBZ0','90','D','10','34',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2Relationship"','35','(''UA''=''T,'')','ECOBOUTBQBZ0','91','D','10','35',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2DOB"','36','(''UA''=''T,'')','ECOBOUTBQBZ0','92','D','10','36',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3LastName"','37','(''UA''=''T,'')','ECOBOUTBQBZ0','93','D','10','37',NULL,'Dependent 3 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3FirstName"','38','(''UA''=''T,'')','ECOBOUTBQBZ0','94','D','10','38',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3Relationship"','39','(''UA''=''T,'')','ECOBOUTBQBZ0','95','D','10','39',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3DOB"','40','(''UA''=''T,'')','ECOBOUTBQBZ0','96','D','10','40',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4LastName"','41','(''UA''=''T,'')','ECOBOUTBQBZ0','97','D','10','41',NULL,'Dependent 4 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4FirstName"','42','(''UA''=''T,'')','ECOBOUTBQBZ0','98','D','10','42',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4Relationship"','43','(''UA''=''T,'')','ECOBOUTBQBZ0','99','D','10','43',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4DOB"','44','(''UA''=''T,'')','ECOBOUTBQBZ0','100','D','10','44',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5LastName"','45','(''UA''=''T,'')','ECOBOUTBQBZ0','101','D','10','45',NULL,'Dependent 5 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5FirstName"','46','(''UA''=''T,'')','ECOBOUTBQBZ0','102','D','10','46',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5Relationship"','47','(''UA''=''T,'')','ECOBOUTBQBZ0','103','D','10','47',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5DOB"','48','(''UA''=''T,'')','ECOBOUTBQBZ0','104','D','10','48',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6LastName"','49','(''UA''=''T,'')','ECOBOUTBQBZ0','105','D','10','49',NULL,'Dependent 6 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6FirstName"','50','(''UA''=''T,'')','ECOBOUTBQBZ0','106','D','10','50',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6Relationship"','51','(''UA''=''T,'')','ECOBOUTBQBZ0','107','D','10','51',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6DOB"','52','(''UA''=''T,'')','ECOBOUTBQBZ0','108','D','10','52',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7LastName"','53','(''UA''=''T,'')','ECOBOUTBQBZ0','109','D','10','53',NULL,'Dependent 7 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7FirstName"','54','(''UA''=''T,'')','ECOBOUTBQBZ0','110','D','10','54',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7Relationship"','55','(''UA''=''T,'')','ECOBOUTBQBZ0','111','D','10','55',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7DOB"','56','(''UA''=''T'')','ECOBOUTBQBZ0','112','D','10','56',NULL,'DOB',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECOBOUTBQB_20210430.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','Z3IKL',NULL,NULL,NULL,'My Cobra QB Export','201806189','EMPEXPORT','ONDEMAND','Jul 30 2018 12:00AM','ECOBOUTBQB',NULL,NULL,NULL,'202104259','Jun 18 2018 12:00AM','Dec 30 1899 12:00AM','202104111',NULL,'','','201806181',dbo.fn_GetTimedKey(),NULL,'ULTI_WPOUTB',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201806189','EMPEXPORT','SCHEDULED',NULL,'ECOBOUTBQB',NULL,NULL,NULL,'201806189','Jun 18 2018  6:38PM','Jun 18 2018  6:38PM','201806181',NULL,'','','201806181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202104309','EMPEXPORT','TEST','May 28 2019  5:47PM','ECOBOUTBQB',NULL,NULL,NULL,'202104309','May 28 2019 12:00AM','Dec 30 1899 12:00AM','202101011','5','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPOUTB',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBOUTBQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBOUTBQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBOUTBQB','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBOUTBQB','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBOUTBQB','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECOBOUTBQB' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECOBOUTBQB' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECOBOUTBQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBOUTBQB_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBOUTBQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBOUTBQB','D10','dbo.U_ECOBOUTBQB_drvTbl',NULL);
IF OBJECT_ID('U_dsi_ECOBOUTBQB_depTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBOUTBQB_depTbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NULL,
    [depid] char(12) NOT NULL,
    [LName] varchar(100) NULL,
    [FName] varchar(100) NULL,
    [cSSN] char(11) NULL,
    [cGender] char(1) NULL,
    [cRel] varchar(16) NOT NULL,
    [cDoB] datetime NULL,
    [drvrank] int NULL
);
IF OBJECT_ID('U_ECOBOUTBQB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECOBOUTBQB_drvTbl] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvClientID] varchar(1) NOT NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvSocialSecurity] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvAddress] varchar(511) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvSex] char(1) NULL,
    [drvDOB] char(10) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvOriginalCoverageEffDate] char(10) NULL,
    [drvEventType] varchar(2) NOT NULL,
    [drvEventDate] char(10) NULL,
    [drvEAPPlan] varchar(1) NOT NULL,
    [drvFlexibleSpending] varchar(1) NOT NULL,
    [drvFSAMonthlyAmount] varchar(1) NOT NULL,
    [drvMedicalCarrierPlanName] varchar(18) NULL,
    [drvMEDLevelofCoverage] varchar(2) NULL,
    [drvAgeRateAmount] varchar(1) NOT NULL,
    [drvDentalCarrierPlanName] varchar(17) NULL,
    [drvDENLevelofCoverage] varchar(2) NULL,
    [drvVisionCarrierPlanName] varchar(12) NULL,
    [drvVISLevelofCoverage] varchar(2) NULL,
    [drvEmployerPayforCOBRA] varchar(1) NOT NULL,
    [drvWhatCoverage] varchar(1) NOT NULL,
    [drvHowLong] varchar(1) NOT NULL,
    [drvDep1LastName] varchar(100) NULL,
    [drvDep1FirstName] varchar(100) NULL,
    [drvDep1Relationship] varchar(16) NULL,
    [drvDep1DOB] char(10) NULL,
    [drvDep2LastName] varchar(100) NULL,
    [drvDep2FirstName] varchar(100) NULL,
    [drvDep2Relationship] varchar(16) NULL,
    [drvDep2DOB] char(10) NULL,
    [drvDep3LastName] varchar(100) NULL,
    [drvDep3FirstName] varchar(100) NULL,
    [drvDep3Relationship] varchar(16) NULL,
    [drvDep3DOB] char(10) NULL,
    [drvDep4LastName] varchar(100) NULL,
    [drvDep4FirstName] varchar(100) NULL,
    [drvDep4Relationship] varchar(16) NULL,
    [drvDep4DOB] char(10) NULL,
    [drvDep5LastName] varchar(100) NULL,
    [drvDep5FirstName] varchar(100) NULL,
    [drvDep5Relationship] varchar(16) NULL,
    [drvDep5DOB] char(10) NULL,
    [drvDep6LastName] varchar(100) NULL,
    [drvDep6FirstName] varchar(100) NULL,
    [drvDep6Relationship] varchar(16) NULL,
    [drvDep6DOB] char(10) NULL,
    [drvDep7LastName] varchar(100) NULL,
    [drvDep7FirstName] varchar(100) NULL,
    [drvDep7Relationship] varchar(16) NULL,
    [drvDep7DOB] char(10) NULL
);
IF OBJECT_ID('U_ECOBOUTBQB_EEList') IS NULL
CREATE TABLE [dbo].[U_ECOBOUTBQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECOBOUTBQB_File') IS NULL
CREATE TABLE [dbo].[U_ECOBOUTBQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBOUTBQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Outbox Systems, Inc.

Created By: Joseph Pham
Business Analyst: Jherilee Williams
Create Date: 06/18/2018
Service Request Number: SR-2018-00201484

Purpose: My Cobra QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2018     SR-2018-000XXXXX   XXXXX
DAgyei                05/28/2019       SR-2019-00234887   Updated plan names        

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECOBOUTBQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECOBOUTBQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECOBOUTBQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECOBOUTBQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECOBOUTBQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBOUTBQB', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBOUTBQB', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECOBOUTBQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECOBOUTBQB';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

--BDM COBRA
DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','MED,DEN')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedTypes', 'MED,DEN,VIS');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate); --@EndDate - @daysstopped)
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate);
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate');--'ActiveOnly') --'stopdate') --'AuditDate')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'UseCobraCoveredDeds', 'Y');
-- Y - use only dedcodes with DedIsCobraCovered = Y. This is the default for Cobra runs.
-- N - use only dedcodes with DedIsCobraCovered <> Y.
-- A - use specified dedcodes for Cobra runs regardless of value in DedIsCobraCovered
--select * from codes where codtable = 'relation'
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse', 'SPS');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'CHL,STC');
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDomPartner', 'DOM')
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDPChild', 'SPS')

--COBRA BDM QE Inserts:
--*********************
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraType', '4');
-- 1> Pull reasons from EepCobraReason and ConCobraReason
-- 2> Pull reasons from EmpHDed and ConCobraReason
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraDate', '2');
-- 1> Pull Cobra dates from EepDateofCobraEvent and ConDateofCobraEvent
-- 2> Pull Cobra dates from benefit stop dates
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraIncludeEmps', 'Y')


EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;


--Fix BDM for Employee Deaths, Valid Dependents, Invalid EE's:
DECLARE @CobraPQBType              VARCHAR(1);
DECLARE @RelationshipsSpouse       VARCHAR(256);
DECLARE @RelationshipsChild        VARCHAR(256);
SELECT @CobraPQBType = CONVERT(VARCHAR(1), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CobraPQBType';
SELECT @RelationshipsSpouse = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsSpouse';
SELECT @RelationshipsChild = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsChild';
SET @CobraPQBType            = dbo.dsi_bdm_fn_Trim(@CobraPQBType);
SET @RelationshipsSpouse     = dbo.dsi_bdm_fn_Trim(@RelationshipsSpouse);
SET @RelationshipsChild      = dbo.dsi_bdm_fn_Trim(@RelationshipsChild);

UPDATE U_dsi_bdm_EmpDeductions
   SET EedValidForExport = 'N',
       EedDedRowStatus   = 'Benefit change reason not valid for Cobra'
  FROM U_dsi_bdm_EmpDeductions
  LEFT JOIN U_dsi_bdm_ChangeReasons WITH (NOLOCK) ON ChgFormatCode = @FormatCode AND EedCobraReason = ChgChangeReason AND ChgTarget = 'EMP'
WHERE EedFormatCode = @FormatCode
   AND EedValidForExport = 'Y'
   AND eedCobraReason in ('210','205');

-----------------------
-- Set the PQB flags
-----------------------

-- Spouses
UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'
  FROM U_dsi_bdm_DepDeductions
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsSpouse) ON item = DbnRelationship
WHERE DbnFormatCode = @FormatCode
   AND DbnValidForExport = 'Y'
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = DbnEEID);


-- Children

UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'
  FROM U_dsi_bdm_DepDeductions a
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsChild) ON item = a.DbnRelationship
WHERE a.DbnFormatCode = @FormatCode
   AND a.DbnValidForExport = 'Y'
   AND a.DbnIsChildOldest = CASE
                               WHEN @CobraPQBType = '1' THEN a.DbnIsChildOldest -- ALL children are PQB
                               ELSE 'Y'
                            END
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = a.DbnEEID)
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_DepDeductions b
                     JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsSpouse) ON item = b.DbnRelationship
                    WHERE b.DbnFormatCode = @FormatCode
                      AND b.DbnValidForExport = 'Y'
                      AND b.DbnEEID = a.DbnEEID);

--*******************END BDM FIX SECTION*********************************

--Update Benefit Option for Dependent PQB record:
--send EE as benefit option when coverage was EE + Child or EE + Spouse, and Dependent lost coverage.
UPDATE U_dsi_bdm_DepDeductions
    set dbnbenoption = 'EE'
from U_dsi_bdm_DepDeductions a
WHERE DbnFormatCode = @FormatCode
    AND DbnValidForExport = 'Y'
    AND dbnispqb = 'Y'
    and dbnbenoption in ('EEC','EEF','EES')
    AND NOT EXISTS(SELECT 1 FROM U_dsi_bdm_DepDeductions b
                    WHERE b.DbnFormatCode = @FormatCode
                      AND b.DbnValidForExport = 'Y'
                      AND b.dbnispqb <> 'Y'
                      AND b.DbnEEID = a.DbnEEID);
/*
--Valid Benefit Options
select distinct bnocode, bnodescription from empded join dedcode on eeddedcode = deddedcode
join benopt on bnocode = eedbenoption where dediscobracovered = 'Y'
*/

--Fix the PQB Record Benefit Option on deduction codes, where the PQB has dependents, and shouldn't be EE coverage offering
declare @PQBLoop1 int, @PQBLoop2 int;

set @PQBLoop1 = 0;
set @PQBLoop2 = (select count(*) from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb = 'Y' and dbnbenoption = 'EE'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb <> 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid));

--select @PQBLoop1, @PQBLoop2

while @PQBLoop1 < @PQBLoop2
BEGIN

declare @dbndeprecid char(12), @dbneeid char(12);
set @dbndeprecid = (select top 1 dbndeprecid from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb = 'Y' and dbnbenoption = 'EE'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb <> 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid));

set @dbneeid = (select distinct dbneeid from dbo.u_dsi_bdm_DepDeductions where dbndeprecid = @dbndeprecid);

update dbo.u_dsi_bdm_DepDeductions
    set dbnBenOption = 'EEF'
from dbo.u_dsi_bdm_DepDeductions
where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnisPQB = 'Y'
    and dbnBenOption = 'EE' and dbndepRecid = @dbndeprecid;

set @PQBLoop1 = @PQBLoop1 + 1;
END;


--Update the Non-PQB records to have correct coverage:
update dbo.u_dsi_bdm_DepDeductions
    set dbnBenOption = 'EEF'
from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb <> 'Y' 
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb = 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid
            and b.dbnbenoption <> d.dbnbenoption
            and dbnbenoption <> 'EE');


if object_id('U_dsi_ECOBOUTBQB_depTbl') is not null
    drop table dbo.U_dsi_ECOBOUTBQB_depTbl;

select distinct
    drveeid = dbneeid,
    drvcoid = dbncoid,
    depid = dbndeprecid,
    LName = connamelast,
    FName = connamefirst,
    cSSN = conssn, 
    cGender = conGender,
    cRel = case when conRelationship = 'SPS' then 'Spouse'
                when conRelationship = 'DP' then 'Domestic Partner'
                when conrelationship = 'CHL' then 'Child'
                when conrelationship = 'STC' then 'Step-Child'
            else '' end,
    cDoB = conDateofBirth,
    drvrank = null

into dbo.U_dsi_ECOBOUTBQB_depTbl
from dbo.u_dsi_bdm_DepDeductions 
    join contacts on dbndeprecid = consystemid
where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y';

--select * from dbo.U_dsi_ECOBOUTBQB_depTbl

with mytemptable
as
(
select *, row_number()over(partition by drveeid order by cDoB) as rnk
from dbo.U_dsi_ECOBOUTBQB_depTbl 
where drvrank is null
)
update mytemptable
set drvrank = '0' + CAST(rnk AS VARCHAR) 
Where drvrank is null;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECOBOUTBQB_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECOBOUTBQB_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBOUTBQB_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '' --'1 ' + ISnULL(EecEmplStatus, 'no') + ' :: ' + ISNULL(EecTermType, 'no') + ' :: ' + ISNULL(eedCobraReason, 'no')
        -- standard fields above and additional driver fields below
        ,drvClientID = ''
        ,drvDivision = ''
        ,drvSocialSecurity = EepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvAddress = EepAddressLine1 + ISNULL(' ' + EepAddressLine2,'')
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvSex = EepGender
        ,drvDOB = convert(char(10),eepDateofBirth,101)
        ,drvMaritalStatus = eepMaritalStatus
        ,drvOriginalCoverageEffDate = convert(char(10),CobraDate,101)
        ,drvEventType = case 
        when eedCobraReason = '210' then 'WW'
                            when eedCobraReason = '204' then 'DV'
                            when eedCobraReason = '201' then 'DC'
                            --when eedCobraReason = '200' then 'TE'
                            WHEN eedCobraReason IN ('202','203') THEN 'RH'
                            WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'IN'
                            WHEN EecEmplStatus = 'T' AND EedCobraReason NOT IN ('202','203') AND EecTermType = 'V' THEN 'VT'
                            --WHEN 
                        else '' end
        ,drvEventDate = convert(char(10),CobraDate,101)
        ,drvEAPPlan = ''
        ,drvFlexibleSpending = ''
        ,drvFSAMonthlyAmount = ''
        ,drvMedicalCarrierPlanName = med.cPlan
        ,drvMEDLevelofCoverage = med.covg
        ,drvAgeRateAmount = ''
        ,drvDentalCarrierPlanName = den.cPlan
        ,drvDENLevelofCoverage = den.covg
        ,drvVisionCarrierPlanName = vis.cPlan
        ,drvVISLevelofCoverage = vis.covg
        ,drvEmployerPayforCOBRA = ''
        ,drvWhatCoverage = ''
        ,drvHowLong = ''
        ,drvDep1LastName = D1.LName
        ,drvDep1FirstName = D1.FName
        ,drvDep1Relationship = D1.cRel
        ,drvDep1DOB = convert(char(10),D1.cDoB,101)
        ,drvDep2LastName = D2.LName
        ,drvDep2FirstName = D2.FName
        ,drvDep2Relationship = D2.cRel
        ,drvDep2DOB = convert(char(10),D2.cDoB,101)
        ,drvDep3LastName = D3.LName
        ,drvDep3FirstName = D3.FName
        ,drvDep3Relationship = D3.cRel
        ,drvDep3DOB = convert(char(10),D3.cDoB,101)
        ,drvDep4LastName = D4.LName
        ,drvDep4FirstName = D4.FName
        ,drvDep4Relationship = D4.cRel
        ,drvDep4DOB = convert(char(10),D4.cDoB,101)
        ,drvDep5LastName = D5.LName
        ,drvDep5FirstName = D5.FName
        ,drvDep5Relationship = D5.cRel
        ,drvDep5DOB = convert(char(10),D5.cDoB,101)
        ,drvDep6LastName = D6.LName
        ,drvDep6FirstName = D6.FName
        ,drvDep6Relationship = D6.cRel
        ,drvDep6DOB = convert(char(10),D6.cDoB,101)
        ,drvDep7LastName = D7.LName
        ,drvDep7FirstName = D7.FName
        ,drvDep7Relationship = D7.cRel
        ,drvDep7DOB = convert(char(10),D7.cDoB,101)
    INTO dbo.U_ECOBOUTBQB_drvTbl
    from dbo.u_dsi_bdm_EElist
        join emppers on eepeeid = xeeid
        JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
            and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
        join (select distinct eedeeid eeid, eedcoid coid, eedCobraReason, max(eedDateofCobraEvent) CobraDate
                from dbo.u_dsi_bdm_EmpDeductions
                where eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
                group by eedeeid, eedcoid, eedCobraReason) ee on xeeid = eeid and xcoid = coid

        left join (select distinct eedeeid eeid, eedcoid coid,
                case when eeddedcode = 'MEDMD' then 'Cigna Medical PPO '--'Cigna OAP MID' --DA 5/28/2019
                     --when eeddedcode = 'MEDCH' then 'CIGNA OAP CHOICE' --DA 5/28/2019 comment out
                     when eeddedcode = 'MEDHD' then 'Cigna Medical CDHP'--'CIGNA HSA OAP '  --DA 5/28/2019
                else '' end cPlan,
                case when eedbenoption = 'EE' then 'EO'
                    when eedbenoption = 'EES' then 'ES'
                    when eedbenoption = 'EEC' then 'EK'
                    when eedbenoption in ('EEF','EEDPF') then 'EF'
                    when eedbenoption = 'EEDP' then 'DP'
                else '' end Covg
                from dbo.u_dsi_bdm_EmpDeductions
                where eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
                    and deddedtype = 'MED') med on xeeid = med.eeid and xcoid = med.coid

        left join (select distinct eedeeid eeid, eedcoid coid,
                case when eeddedcode = 'DPPO' then 'Cigna Dental High'--'Cigna DPPO' --DA 5/28/2019
                     --when eeddedcode = 'DHMO' then 'DHMO Cigna Dental' --DA 5/28/2019 comment out
                     when eeddedcode = 'DPPOL' then 'Cigna Dental Low'--DA 5/28/2019 added
                else '' end cPlan,
                case when eedbenoption = 'EE' then 'EO'
                    when eedbenoption = 'EES' then 'ES'
                    when eedbenoption = 'EEC' then 'EK'
                    when eedbenoption in ('EEF','EEDPF') then 'EF'
                    when eedbenoption = 'EEDP' then 'DP'
                else '' end Covg
                from dbo.u_dsi_bdm_EmpDeductions
                where eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
                    and deddedtype = 'DEN') den on xeeid = den.eeid and xcoid = den.coid

        left join (select distinct eedeeid eeid, eedcoid coid,
                  'Cigna Vision' cPlan,
                case when eedbenoption = 'EE' then 'EO'
                    when eedbenoption = 'EES' then 'ES'
                    when eedbenoption = 'EEC' then 'EK'
                    when eedbenoption in ('EEF','EEDPF') then 'EF'
                    when eedbenoption = 'EEDP' then 'DP'
                else '' end Covg
                from dbo.u_dsi_bdm_EmpDeductions
                where eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
                    and deddedtype = 'VIS') vis on xeeid = vis.eeid and xcoid = vis.coid

        left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '01') d1 on d1.drveeid = xeeid and d1.drvcoid = xcoid
        left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '02') d2 on d2.drveeid = xeeid and d2.drvcoid = xcoid
        left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '03') d3 on d3.drveeid = xeeid and d3.drvcoid = xcoid
        left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '04') d4 on d4.drveeid = xeeid and d4.drvcoid = xcoid
        left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '05') d5 on d5.drveeid = xeeid and d5.drvcoid = xcoid
        left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '06') d6 on d6.drveeid = xeeid and d6.drvcoid = xcoid
        left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '07') d7 on d7.drveeid = xeeid and d7.drvcoid = xcoid
      where xFormatCode = @FormatCode;
    ;

    INSERT INTO dbo.U_ECOBOUTBQB_drvTbl
    SELECT DISTINCT 
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '' --'2' -- ISNULL(EecEmplStatus, 'no') + ' :: ' + ISNULL(EecTermType, 'no')
        -- standard fields above and additional driver fields below
        ,drvClientID = ''
        ,drvDivision = ''
        ,drvSocialSecurity = ConSSN
        ,drvLastName = ConNameLast
        ,drvFirstName = ConNameFirst
        ,drvAddress = ConAddressLine1 + ISNULL(' ' + ConAddressLine2,'')
        ,drvCity = ConAddressCity
        ,drvState = ConAddressState
        ,drvZip = ConAddressZipCode
        ,drvSex = ConGender
        ,drvDOB = convert(char(10),eepDateofBirth,101)
        ,drvMaritalStatus = ''
        ,drvOriginalCoverageEffDate = convert(char(10),CobraDate,101)
        ,drvEventType = case when dbnCobraReason = '210' then 'WW'
                            when dbnCobraReason = '204' then 'DV'
                            when dbnCobraReason = '201' then 'DC'
                            --when eedCobraReason = '200' then 'TE'
                            WHEN dbnCobraReason IN ('202','203') THEN 'RH'
                            WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'IN'
                            WHEN EecEmplStatus = 'T' AND DbnCobraReason NOT IN ('202','203') AND EecTermType = 'V' THEN 'VT'
                        else '' end
        ,drvEventDate = convert(char(10),CobraDate,101)
        ,drvEAPPlan = ''
        ,drvFlexibleSpending = ''
        ,drvFSAMonthlyAmount = ''
        ,drvMedicalCarrierPlanName = med.cPlan
        ,drvMEDLevelofCoverage = med.covg
        ,drvAgeRateAmount = ''
        ,drvDentalCarrierPlanName = den.cPlan
        ,drvDENLevelofCoverage = den.covg
        ,drvVisionCarrierPlanName = vis.cPlan
        ,drvVISLevelofCoverage = vis.covg
        ,drvEmployerPayforCOBRA = ''
        ,drvWhatCoverage = ''
        ,drvHowLong = ''
        ,drvDep1LastName = D1.LName
        ,drvDep1FirstName = D1.FName
        ,drvDep1Relationship = D1.cRel
        ,drvDep1DOB = convert(char(10),D1.cDoB,101)
        ,drvDep2LastName = D2.LName
        ,drvDep2FirstName = D2.FName
        ,drvDep2Relationship = D2.cRel
        ,drvDep2DOB = convert(char(10),D2.cDoB,101)
        ,drvDep3LastName = D3.LName
        ,drvDep3FirstName = D3.FName
        ,drvDep3Relationship = D3.cRel
        ,drvDep3DOB = convert(char(10),D3.cDoB,101)
        ,drvDep4LastName = D4.LName
        ,drvDep4FirstName = D4.FName
        ,drvDep4Relationship = D4.cRel
        ,drvDep4DOB = convert(char(10),D4.cDoB,101)
        ,drvDep5LastName = D5.LName
        ,drvDep5FirstName = D5.FName
        ,drvDep5Relationship = D5.cRel
        ,drvDep5DOB = convert(char(10),D5.cDoB,101)
        ,drvDep6LastName = D6.LName
        ,drvDep6FirstName = D6.FName
        ,drvDep6Relationship = D6.cRel
        ,drvDep6DOB = convert(char(10),D6.cDoB,101)
        ,drvDep7LastName = D7.LName
        ,drvDep7FirstName = D7.FName
        ,drvDep7Relationship = D7.cRel
        ,drvDep7DOB = convert(char(10),D7.cDoB,101)
    from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid, dbnCobraReason, max(dbnDateofCobraEvent) CobraDate
            from dbo.u_dsi_bdm_DepDeductions
            where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
            and dbnispqb = 'Y'
            group by dbneeid, dbncoid, dbndeprecid, dbnCobraReason) ee on xeeid = eeid and xcoid = coid
    join contacts on dbndeprecid = consystemid
    left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid,
            case when dbndedcode = '' then ''
            else '' end cPlan,
            case when dbnbenoption = 'EE' then 'EO'
                    when dbnbenoption = 'EES' then 'ES'
                    when dbnbenoption = 'EEC' then 'EK'
                    when dbnbenoption in ('EEF','EEDPF') then 'EF'
                    when dbnbenoption = 'EEDP' then 'DP'
            else '' end Covg
            from dbo.u_dsi_bdm_DepDeductions
            where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y' and dbnispqb = 'Y'
                and deddedtype = 'MED') med on xeeid = med.eeid and xcoid = med.coid and med.depid = dbndeprecid
    left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid,
            case when dbndedcode = '' then ''
            else '' end cPlan,
            case when dbnbenoption = 'EE' then 'EO'
                    when dbnbenoption = 'EES' then 'ES'
                    when dbnbenoption = 'EEC' then 'EK'
                    when dbnbenoption in ('EEF','EEDPF') then 'EF'
                    when dbnbenoption = 'EEDP' then 'DP'
            else '' end Covg
            from dbo.u_dsi_bdm_DepDeductions
            where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y' and dbnispqb = 'Y'
                and deddedtype = 'DEN') den on xeeid = den.eeid and xcoid = den.coid and den.depid = dbndeprecid
    left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid,
            case when dbndedcode = '' then ''
            else '' end cPlan,
            case when dbnbenoption = 'EE' then 'EO'
                    when dbnbenoption = 'EES' then 'ES'
                    when dbnbenoption = 'EEC' then 'EK'
                    when dbnbenoption in ('EEF','EEDPF') then 'EF'
                    when dbnbenoption = 'EEDP' then 'DP'
            else '' end Covg
            from dbo.u_dsi_bdm_DepDeductions
            where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y' and dbnispqb = 'Y'
                and deddedtype = 'VIS') vis on xeeid = vis.eeid and xcoid = vis.coid and vis.depid = dbndeprecid
    left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '01') d1 on d1.drveeid = xeeid and d1.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '02') d2 on d2.drveeid = xeeid and d2.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '03') d3 on d3.drveeid = xeeid and d3.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '04') d4 on d4.drveeid = xeeid and d4.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '05') d5 on d5.drveeid = xeeid and d5.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '06') d6 on d6.drveeid = xeeid and d6.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ECOBOUTBQB_depTbl where drvrank = '06') d7 on d7.drveeid = xeeid and d7.drvcoid = xcoid
  where xFormatCode = @FormatCode;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_ECOBOUTBQB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ECOBOUTBQB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwECOBOUTBQB_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ECOBOUTBQB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECOBOUTBQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101011'
       ,expStartPerControl     = '202101011'
       ,expLastEndPerControl   = '202104309'
       ,expEndPerControl       = '202104309'
WHERE expFormatCode = 'ECOBOUTBQB'
    AND ExpExportCode = 'TEST'
;


**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECOBOUTBQB_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECOBOUTBQB_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort