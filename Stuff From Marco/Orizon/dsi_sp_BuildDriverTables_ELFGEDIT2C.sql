SET NOCOUNT ON;
IF OBJECT_ID('U_ELFGEDIT2C_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELFGEDIT2C_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELFGEDIT2C_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELFGEDIT2C' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELFGEDIT2C_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELFGEDIT2C_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELFGEDIT2C') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELFGEDIT2C];
GO
IF OBJECT_ID('U_ELFGEDIT2C_File') IS NOT NULL DROP TABLE [dbo].[U_ELFGEDIT2C_File];
GO
IF OBJECT_ID('U_ELFGEDIT2C_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELFGEDIT2C_EEList];
GO
IF OBJECT_ID('U_dsi_ELFGEDIT2C_volcovTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELFGEDIT2C_volcovTbl];
GO
IF OBJECT_ID('U_dsi_ELFGEDIT2C_volADDcovTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELFGEDIT2C_volADDcovTbl];
GO
IF OBJECT_ID('U_dsi_ELFGEDIT2C_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELFGEDIT2C_drvTbl];
GO
IF OBJECT_ID('U_dsi_ELFGEDIT2C_depTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELFGEDIT2C_depTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELFGEDIT2C';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELFGEDIT2C';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELFGEDIT2C';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELFGEDIT2C';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELFGEDIT2C';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ELFGEDIT2C','Lincoln EDI file V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','6000','S','N','AZJTDT0000K2','N','Jan 20 2016 12:01PM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACTION TYPE"','1','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHANGE DATE"','2','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP CHANGE DATE"','3','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','23',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERMINATION DATE"','4','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr First Name"','5','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','47',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Last Name"','6','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','62',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Middle Initial"','7','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','76',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr SSN"','8','(''DA''=''T,'')','AZJTDT0000K2','8','H','01','94',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Gender"','9','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','102',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr DOB"','10','(''DA''=''T,'')','AZJTDT0000K2','8','H','01','113',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"App Sign Date"','11','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','121',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation"','12','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hrs per Week"','13','(''DA''=''T,'')','AZJTDT0000K2','12','H','01','144',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Amt"','14','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','156',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Code"','15','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','166',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sal Eff Date"','16','(''DA''=''T,'')','AZJTDT0000K2','12','H','01','177',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 1"','17','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','189',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Addr 2"','18','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','200',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr City"','19','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','211',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr State"','20','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','220',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Code"','21','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','230',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Zip Plus 4"','22','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','243',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','23','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','258',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','24','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','268',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Ext"','25','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','278',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','26','(''DA''=''T,'')','AZJTDT0000K2','12','H','01','292',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse First Name"','27','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','304',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Last Name"','28','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','321',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Middle Init"','29','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','337',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse SSN"','30','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','355',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Gender"','31','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','365',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse DOB"','32','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','378',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse SOB"','33','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','388',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Emp SOB"','34','(''DA''=''T,'')','AZJTDT0000K2','7','H','01','398',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','35','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','405',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','36','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','419',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email Address"','37','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','430',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Flag"','38','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','443',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Exempt Flag"','39','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','453',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Plan Date"','40','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','464',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene First Name"','41','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','480',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Last Name"','42','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','501',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Middle Init"','43','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','521',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Relationship"','44','(''DA''=''T,'')','AZJTDT0000K2','23','H','01','541',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 1"','45','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','564',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Address 2"','46','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','584',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene City"','47','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','604',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene State"','48','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','619',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Code"','49','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','635',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene Zip Plus 4"','50','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','654',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pri Bene SSN"','51','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','675',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene First Name"','52','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','689',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Last Name"','53','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','709',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Middle Init"','54','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','728',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Relationship"','55','(''DA''=''T,'')','AZJTDT0000K2','22','H','01','747',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 1"','56','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','769',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Address 2"','57','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','788',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene City"','58','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','807',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene State"','59','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','821',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Code"','60','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','836',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene Zip Plus 4"','61','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','854',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Co Bene SSN"','62','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','874',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Beneficiary Comments"','63','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','887',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Policy Number"','64','(''DA''=''T,'')','AZJTDT0000K2','22','H','01','907',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident BLOC Account Num"','65','(''DA''=''T,'')','AZJTDT0000K2','25','H','01','929',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sort Group"','66','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','954',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Eff Date"','67','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','973',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Plan Code"','68','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','990',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Class Code"','69','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','1008',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Tier Code"','70','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','1027',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Health Asses Tier"','71','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','1045',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Tier"','72','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','1062',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Disability Amount"','73','(''DA''=''T,'')','AZJTDT0000K2','26','H','01','1075',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Tier"','74','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','1101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Benefit Period"','75','(''DA''=''T,'')','AZJTDT0000K2','26','H','01','1117',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident DI Elim Period"','76','(''DA''=''T,'')','AZJTDT0000K2','23','H','01','1143',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident Sickness Disability Amount"','77','(''DA''=''T,'')','AZJTDT0000K2','35','H','01','1166',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident/sick Tier"','78','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','1201',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident/sick DI"','79','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','1219',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Accident/sick DI Elim Period"','80','(''DA''=''T,'')','AZJTDT0000K2','28','H','01','1235',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Policy Number"','81','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','1263',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI BLOC Account Num/Sort Group"','82','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','1279',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Eff Date"','83','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','1309',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Plan Code"','84','(''DA''=''T,'')','AZJTDT0000K2','12','H','01','1320',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CI Class Code"','85','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','1332',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Approved"','86','(''DA''=''T,'')','AZJTDT0000K2','29','H','01','1345',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Principal Sum Amt Pending"','87','(''DA''=''T,'')','AZJTDT0000K2','28','H','01','1374',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Approved"','88','(''DA''=''T,'')','AZJTDT0000K2','29','H','01','1402',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Principal Sum Amt Pending"','89','(''DA''=''T,'')','AZJTDT0000K2','28','H','01','1431',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Approved"','90','(''DA''=''T,'')','AZJTDT0000K2','29','H','01','1459',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Principal Sum Amt Pending"','91','(''DA''=''T,'')','AZJTDT0000K2','28','H','01','1488',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Approved"','92','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','1516',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Heart Amt Pending"','93','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','1537',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Approved"','94','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','1557',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Heart Amt Pending"','95','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','1578',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Approved"','96','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','1598',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Heart Amt Pending"','97','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','1619',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Approved"','98','(''DA''=''T,'')','AZJTDT0000K2','22','H','01','1639',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Cancer Amt Pending"','99','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','1661',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Approved"','100','(''DA''=''T,'')','AZJTDT0000K2','22','H','01','1682',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Cancer Amt Pending"','101','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','1704',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Approved"','102','(''DA''=''T,'')','AZJTDT0000K2','22','H','01','1725',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Cancer Amt Pending"','103','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','1747',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Approved"','104','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','1768',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Organ Amt Pending"','105','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','1789',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Approved"','106','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','1809',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Organ Amt Pending"','107','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','1830',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Approved"','108','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','1850',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Organ Amt Pending"','109','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','1871',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Approved"','110','(''DA''=''T,'')','AZJTDT0000K2','31','H','01','1891',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Quality of Life Amt Pending"','111','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','1922',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Approved"','112','(''DA''=''T,'')','AZJTDT0000K2','31','H','01','1952',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Quality of Life Amt Pending"','113','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','1983',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Approved"','114','(''DA''=''T,'')','AZJTDT0000K2','31','H','01','2013',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Quality of Life Amt Pending"','115','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','2044',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Approved"','116','(''DA''=''T,'')','AZJTDT0000K2','27','H','01','2074',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Category Amt Pending"','117','(''DA''=''T,'')','AZJTDT0000K2','26','H','01','2101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Treatment Care Y/N"','118','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','2127',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Treatment Care Y/N"','119','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','2148',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Treatment Care Y/N"','120','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','2169',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE DI Y/N"','121','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','2190',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP DI Y/N"','122','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','2199',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Accident Y/N"','123','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','2208',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP Accident Y/N"','124','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','2223',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CH Accident Y/N"','125','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','2238',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Occ/HIV Y/N"','126','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2253',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Bill. Location A/C Number"','127','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','2267',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Eff Date"','128','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','2297',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Plan Code"','129','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2310',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Class Code"','130','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','2324',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Life Cvgs"','131','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','2339',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Bill. Location A/C Number"','132','(''DA''=''T,'')','AZJTDT0000K2','28','H','01','2348',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Eff Date"','133','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','2376',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Plan Code"','134','(''DA''=''T,'')','AZJTDT0000K2','12','H','01','2387',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Class Code"','135','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','2399',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WI Cvgs"','136','(''DA''=''T,'')','AZJTDT0000K2','7','H','01','2412',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Bill. Location A/C Number"','137','(''DA''=''T,'')','AZJTDT0000K2','29','H','01','2419',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eff Date"','138','(''DA''=''T,'')','AZJTDT0000K2','12','H','01','2448',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Plan Code"','139','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','2460',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Class Code"','140','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2473',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Cvgs"','141','(''DA''=''T,'')','AZJTDT0000K2','8','H','01','2487',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Bill. Location A/C Number"','142','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','2495',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Eff Date"','143','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','2525',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Plan Code"','144','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2538',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Class Code"','145','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','2552',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Cvgs"','146','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','2567',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Coverage Tier"','147','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','2576',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dent Other Ins"','148','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2594',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Bill. Location A/C Number"','149','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','2608',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Eff Date"','150','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','2638',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Plan Code"','151','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2651',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Class Code"','152','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','2665',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Cvgs"','153','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','2680',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO Coverage Tier"','154','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','2689',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DHMO PCP"','155','(''DA''=''T,'')','AZJTDT0000K2','8','H','01','2707',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Bill. Location A/C Number"','156','(''DA''=''T,'')','AZJTDT0000K2','29','H','01','2715',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Eff Date"','157','(''DA''=''T,'')','AZJTDT0000K2','12','H','01','2744',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Plan Code"','158','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','2756',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Class Code"','159','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2769',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Coverage Tier"','160','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','2783',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Other Ins"','161','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','2800',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Emp Waiver"','162','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2813',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Dep Waiver"','163','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2827',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LVC Other Ins Type"','164','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','2841',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Bill. Location A/C Number"','165','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','2859',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Eff Date"','166','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','2889',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Plan Code"','167','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2902',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Class Code"','168','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','2916',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Coverage Tier"','169','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','2931',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Other Ins"','170','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','2949',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Emp Waiver"','171','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','2963',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Dep Waiver"','172','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','2978',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLVC Other Ins Type"','173','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','2993',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Bill. Location A/C Number"','174','(''DA''=''T,'')','AZJTDT0000K2','29','H','01','3012',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Eff Date"','175','(''DA''=''T,'')','AZJTDT0000K2','12','H','01','3041',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Plan Code"','176','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3053',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Class Code"','177','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','3066',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Cvgs"','178','(''DA''=''T,'')','AZJTDT0000K2','8','H','01','3080',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Coverage Tier"','179','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','3088',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDN Other Ins"','180','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3105',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDMO Bill. Location A/C Number"','181','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','3118',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDMO Eff Date"','182','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3148',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDMO Plan Code"','183','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','3161',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDMO Class Code"','184','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3175',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDMO Cvgs"','185','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','3190',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDMO Coverage Tier"','186','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','3199',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VDMO PCP"','187','(''DA''=''T,'')','AZJTDT0000K2','8','H','01','3217',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Bill. Location A/C Number"','188','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','3225',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Eff Date"','189','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3255',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Plan Code"','190','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','3268',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Class Code"','191','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3282',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Cvgs"','192','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','3297',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF VADD Option"','193','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','3306',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Bill. Location A/C Number"','194','(''DA''=''T,'')','AZJTDT0000K2','29','H','01','3322',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Eff Date"','195','(''DA''=''T,'')','AZJTDT0000K2','12','H','01','3351',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Plan Code"','196','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3363',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Class Code"','197','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','3376',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Cvgs"','198','(''DA''=''T,'')','AZJTDT0000K2','8','H','01','3390',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Amt"','199','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3398',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Elim Period"','200','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3413',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VWI Benefit Pct"','201','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3428',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Bill. Location A/C Number"','202','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','3443',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Eff Date"','203','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3473',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Plan Code"','204','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','3486',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Class Code"','205','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3500',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Cvgs"','206','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','3515',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Duration"','207','(''DA''=''T,'')','AZJTDT0000K2','21','H','01','3524',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Amt"','208','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','3545',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Elim Period"','209','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','3561',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLTD Benefit Pct"','210','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','3577',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Bill. Location A/C Number"','211','(''DA''=''T,'')','AZJTDT0000K2','30','H','01','3593',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Eff Date"','212','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3623',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Plan Code"','213','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','3636',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Class Code"','214','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3650',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STAD Cvgs"','215','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','3665',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reason Code"','216','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','3674',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reason Eff Date"','217','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3685',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mbr Comments"','218','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3700',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ASO Indicator Y/N"','219','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','3713',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Emp Smoker"','220','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3730',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Spouse Smoker"','221','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','3745',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VLIF Spouse DOB"','222','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3763',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep First Name"','223','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','3778',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Last Name"','224','(''DA''=''T,'')','AZJTDT0000K2','14','H','01','3793',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep M I"','225','(''DA''=''T,'')','AZJTDT0000K2','7','H','01','3807',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Gender"','226','(''DA''=''T,'')','AZJTDT0000K2','11','H','01','3814',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DOB"','227','(''DA''=''T,'')','AZJTDT0000K2','8','H','01','3825',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Relationship Code"','228','(''DA''=''T,'')','AZJTDT0000K2','22','H','01','3833',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Student Code"','229','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','3855',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep Cvg Indicator"','230','(''DA''=''T,'')','AZJTDT0000K2','18','H','01','3872',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep DHMO PCP"','231','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3890',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 First Name"','232','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','3903',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Last Name"','233','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','3920',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 M I"','234','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','3936',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Gender"','235','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','3945',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 DOB"','236','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','3958',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Relationship Code"','237','(''DA''=''T,'')','AZJTDT0000K2','24','H','01','3968',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Student Code"','238','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','3992',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 Cvg Indicator"','239','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','4011',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 2 DHMO PCP"','240','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','4031',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 First Name"','241','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','4046',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Last Name"','242','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','4063',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 M I"','243','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','4079',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Gender"','244','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','4088',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 DOB"','245','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','4101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Relationship Code"','246','(''DA''=''T,'')','AZJTDT0000K2','24','H','01','4111',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Student Code"','247','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','4135',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 Cvg Indicator"','248','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','4154',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 3 DHMO PCP"','249','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','4174',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 First Name"','250','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','4189',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Last Name"','251','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','4206',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 M I"','252','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','4222',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Gender"','253','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','4231',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 DOB"','254','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','4244',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Relationship Code"','255','(''DA''=''T,'')','AZJTDT0000K2','24','H','01','4254',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Student Code"','256','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','4278',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 Cvg Indicator"','257','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','4297',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 4 DHMO PCP"','258','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','4317',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 First Name"','259','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','4332',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Last Name"','260','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','4349',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 M I"','261','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','4365',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Gender"','262','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','4374',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 DOB"','263','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','4387',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Relationship Code"','264','(''DA''=''T,'')','AZJTDT0000K2','24','H','01','4397',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Student Code"','265','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','4421',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 Cvg Indicator"','266','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','4440',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 5 DHMO PCP"','267','(''DA''=''T,'')','AZJTDT0000K2','15','H','01','4460',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 First Name"','268','(''DA''=''T,'')','AZJTDT0000K2','17','H','01','4475',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Last Name"','269','(''DA''=''T,'')','AZJTDT0000K2','16','H','01','4492',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 M I"','270','(''DA''=''T,'')','AZJTDT0000K2','9','H','01','4508',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Gender"','271','(''DA''=''T,'')','AZJTDT0000K2','13','H','01','4517',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 DOB"','272','(''DA''=''T,'')','AZJTDT0000K2','10','H','01','4530',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Relationship Code"','273','(''DA''=''T,'')','AZJTDT0000K2','24','H','01','4540',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Student Code"','274','(''DA''=''T,'')','AZJTDT0000K2','19','H','01','4564',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 Cvg Indicator"','275','(''DA''=''T,'')','AZJTDT0000K2','20','H','01','4583',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dep 6 DHMO PCP"','276','(''DA''=''T'')','AZJTDT0000K2','15','H','01','4603',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActionType"','1','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','1',NULL,'ACTION TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChangeDate"','2','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','2',NULL,'CHANGE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepChangeDate"','3','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','12',NULL,'DEP CHANGE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','4','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','22',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','32',NULL,'Mbr First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','82',NULL,'Mbr Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMI"','7','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','132',NULL,'Mbr Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvESSN"','8','(''UA''=''T,'')','AZJTDT0000K2','9','D','02','133',NULL,'Mbr SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','142',NULL,'Mbr Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','10','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','143',NULL,'Mbr DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAppSignDate"','11','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','153',NULL,'App Sign Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','12','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','163',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsPerWeek"','13','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','213',NULL,'Hrs per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','14','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','219',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryCode"','15','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','229',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalEffDate"','16','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','230',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','17','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','240',NULL,'Mbr Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','18','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','290',NULL,'Mbr Addr 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','19','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','340',NULL,'Mbr City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','20','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','390',NULL,'Mbr State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIP"','21','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','392',NULL,'Mbr Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIPplus"','22','(''UA''=''T,'')','AZJTDT0000K2','5','D','02','402',NULL,'Mbr Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHome"','23','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','407',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneBusiness"','24','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','417',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBusinessExt"','25','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','427',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','26','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','437',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsNameFirst"','27','(''UA''=''T,'')','AZJTDT0000K2','35','D','02','442',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpsNameLast"','28','(''UA''=''T,'')','AZJTDT0000K2','35','D','02','477',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseMI"','29','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','512',NULL,'Spouse Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSSN"','30','(''UA''=''T,'')','AZJTDT0000K2','11','D','02','513',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','31','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','524',NULL,'Spouse Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDOB"','32','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','525',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseStateOB"','33','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','535',NULL,'Spouse SOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStateOfBirth"','34','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','537',NULL,'Emp SOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritialStat"','35','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','539',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','36','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','540',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','37','(''UA''=''T,'')','AZJTDT0000K2','100','D','02','550',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionFlag"','38','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','650',NULL,'Union Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptFlag"','39','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','651',NULL,'Exempt Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHlthPlanDate"','40','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','652',NULL,'Health Plan Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenFName"','41','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','662',NULL,'Pri Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenLName"','42','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','712',NULL,'Pri Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenMName"','43','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','762',NULL,'Pri Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenRelation"','44','(''UA''=''T,'')','AZJTDT0000K2','9','D','02','812',NULL,'Pri Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenAdd1"','45','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','821',NULL,'Pri Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenAdd2"','46','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','871',NULL,'Pri Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenCity"','47','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','921',NULL,'Pri Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenST"','48','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','971',NULL,'Pri Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenZIP"','49','(''UA''=''T,'')','AZJTDT0000K2','5','D','02','973',NULL,'Pri Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenZIPplus"','50','(''UA''=''T,'')','AZJTDT0000K2','4','D','02','978',NULL,'Pri Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriBenSSN"','51','(''UA''=''T,'')','AZJTDT0000K2','9','D','02','982',NULL,'Pri Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenFName"','52','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','991',NULL,'Co Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenLName"','53','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','1041',NULL,'Co Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenMName"','54','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','1091',NULL,'Co Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenRelation"','55','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','1141',NULL,'Co Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenAdd1"','56','(''UA''=''T,'')','AZJTDT0000K2','5','D','02','1143',NULL,'Co Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenAdd2"','57','(''UA''=''T,'')','AZJTDT0000K2','4','D','02','1148',NULL,'Co Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenCity"','58','(''UA''=''T,'')','AZJTDT0000K2','9','D','02','1152',NULL,'Co Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenST"','59','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','1161',NULL,'Co Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenZIP"','60','(''UA''=''T,'')','AZJTDT0000K2','5','D','02','1163',NULL,'Co Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenZIPplus"','61','(''UA''=''T,'')','AZJTDT0000K2','4','D','02','1168',NULL,'Co Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoBenSSN"','62','(''UA''=''T,'')','AZJTDT0000K2','9','D','02','1172',NULL,'Co Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenComments"','63','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','1181',NULL,'Beneficiary Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccPolicyNo"','64','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1231',NULL,'Accident Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccBLOCAcctNo"','65','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1261',NULL,'Accident BLOC Account Num',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccSortGrp"','66','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1291',NULL,'Accident Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccEffDate"','67','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1321',NULL,'Accident Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccPlanCode"','68','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1351',NULL,'Accident Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccClassCode"','69','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1381',NULL,'Accident Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccTierCode"','70','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1411',NULL,'Accident Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHealthAssTier"','71','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1441',NULL,'Health Asses Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHospitalTier"','72','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1471',NULL,'Hospital Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccDisabilityAmt"','73','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1501',NULL,'Accident Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccDITier"','74','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1531',NULL,'Accident DI Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccDIBenPeriod"','75','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1561',NULL,'Accident DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccDIElimPeriod"','76','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1591',NULL,'Accident DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccSickDisAmt"','77','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1621',NULL,'Accident Sickness Disability A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccSickTier"','78','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1651',NULL,'Accident/sick Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccSickDIAmt"','79','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1681',NULL,'Accident/sick DI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccSickDIElimPeriod"','80','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1711',NULL,'Accident/sick DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIPolicyNo"','81','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1741',NULL,'CI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIBLOCAccNoSortGrp"','82','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1771',NULL,'CI BLOC Account Num/Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIEffDate"','83','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1801',NULL,'CI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIPlanCode"','84','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1831',NULL,'CI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCIClassCode"','85','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1861',NULL,'CI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPrinAmtApproved"','86','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','1891',NULL,'EE Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPrinAmtPending"','87','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','1921',NULL,'EE Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPPrinAmtApproved"','88','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','1951',NULL,'SP Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPPrinAmtPending"','89','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','1981',NULL,'SP Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHPrinAmtApproved"','90','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2011',NULL,'CH Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHPrinAmtPending"','91','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2041',NULL,'CH Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEHeartAmtApproved"','92','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2071',NULL,'EE Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEHeartAmtPending"','93','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2101',NULL,'EE Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPHeartAmtApproved"','94','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2131',NULL,'SP Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPHeartAmtPending"','95','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2161',NULL,'SP Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHHeartAmtApproved"','96','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2191',NULL,'CH Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHHeartAmtPending"','97','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2221',NULL,'CH Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECanAmtApproved"','98','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2251',NULL,'EE Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEECanAmtPending"','99','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2281',NULL,'EE Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCanAmtApproved"','100','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2311',NULL,'SP Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPCanAmtPending"','101','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2341',NULL,'SP Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHCanAmtApproved"','102','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2371',NULL,'CH Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHCanAmtPending"','103','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2401',NULL,'CH Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEOrganAmtApproved"','104','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2431',NULL,'EE Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEOrganAmtPending"','105','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2461',NULL,'EE Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPOrganAmtApproved"','106','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2491',NULL,'SP Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPOrganAmtPending"','107','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2521',NULL,'SP Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHOrganAmtApproved"','108','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2551',NULL,'CH Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHOrganAmtPending"','109','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2581',NULL,'CH Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEQualAmtApproved"','110','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2611',NULL,'EE Quality of Life Amt Approve',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEQualAmtPending"','111','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2641',NULL,'EE Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPQualAmtApproved"','112','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2671',NULL,'SP Quality of Life Amt Approve',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPQualAmtPending"','113','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2701',NULL,'SP Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHQualAmtApproved"','114','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2731',NULL,'CH Quality of Life Amt Approve',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHQualAmtPending"','115','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2761',NULL,'CH Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHCatAmtApproved"','116','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2791',NULL,'Child Category Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHCatAmtPending"','117','(''SS''=''T,'')','AZJTDT0000K2','30','D','02','2821',NULL,'Child Category Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEETreatmentCare"','118','(''SS''=''T,'')','AZJTDT0000K2','1','D','02','2851',NULL,'EE Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPTreatmentCare"','119','(''SS''=''T,'')','AZJTDT0000K2','1','D','02','2852',NULL,'SP Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHTreatmentCare"','120','(''SS''=''T,'')','AZJTDT0000K2','1','D','02','2853',NULL,'CH Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDI"','121','(''SS''=''T,'')','AZJTDT0000K2','1','D','02','2854',NULL,'EE DI Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPDI"','122','(''SS''=''T,'')','AZJTDT0000K2','1','D','02','2855',NULL,'SP DI Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEAcc"','123','(''SS''=''T,'')','AZJTDT0000K2','1','D','02','2856',NULL,'EE Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPAcc"','124','(''SS''=''T,'')','AZJTDT0000K2','1','D','02','2857',NULL,'SP Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHAcc"','125','(''SS''=''T,'')','AZJTDT0000K2','1','D','02','2858',NULL,'CH Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEOccHIV"','126','(''SS''=''T,'')','AZJTDT0000K2','1','D','02','2859',NULL,'EE Occ/HIV Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeGrpAcctNo"','127','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','2860',NULL,'Life Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeEffDate"','128','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','2890',NULL,'Life Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifePlanCode"','129','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','2900',NULL,'Life Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeClassCode"','130','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','2906',NULL,'Life Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLiveCvg"','131','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','2912',NULL,'Life Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIGrpAcctNo"','132','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','2927',NULL,'WI Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIEffDate"','133','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','2957',NULL,'WI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIPlanCode"','134','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','2967',NULL,'WI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWIClassCode"','135','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','2973',NULL,'WI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWICvg"','136','(''UA''=''T,'')','AZJTDT0000K2','15','D','02','2979',NULL,'WI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDGrpAcctNo"','137','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','2994',NULL,'LTD Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEffDate"','138','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','3024',NULL,'LTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDPlanCode"','139','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','3034',NULL,'LTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDClassCode"','140','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','3040',NULL,'LTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDCvg"','141','(''UA''=''T,'')','AZJTDT0000K2','15','D','02','3046',NULL,'LTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentGrpAcctNo"','142','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3061',NULL,'Dent Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentEffDate"','143','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','3091',NULL,'Dent Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentPlanCode"','144','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','3101',NULL,'Dent Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentClassCode"','145','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','3107',NULL,'Dent Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentCvg"','146','(''UA''=''T,'')','AZJTDT0000K2','15','D','02','3113',NULL,'Dent Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentCvgTier"','147','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','3128',NULL,'Dent Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDentOtherIns"','148','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','3129',NULL,'Dent Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDHMOAcctNo"','149','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3130',NULL,'DHMO Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDHMOEffDate"','150','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','3160',NULL,'DHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDHMOPlanCode"','151','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','3170',NULL,'DHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDHMOClassCode"','152','(''UA''=''T,'')','AZJTDT0000K2','6','D','02','3176',NULL,'DHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDHMOCvg"','153','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3182',NULL,'DHMO Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDHMOTier"','154','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3212',NULL,'DHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDHMOPCP"','155','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3242',NULL,'DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLVCAcctNo"','156','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3272',NULL,'LVC Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLVCEffDate"','157','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','3302',NULL,'LVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLVCPlanCode"','158','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','3312',NULL,'LVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLVCClassCode"','159','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','3314',NULL,'LVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLVCCTier"','160','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3316',NULL,'LVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLVCOtherIns"','161','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3346',NULL,'LVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLVCEmpWaiver"','162','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3376',NULL,'LVC Emp Waiver',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLVCDepWaiver"','163','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3406',NULL,'LVC Dep Waiver',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLVCOtherInsType"','164','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3436',NULL,'LVC Other Ins Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLVCAcctNo"','165','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3466',NULL,'VLVC Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLVCEffDate"','166','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','3496',NULL,'VLVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLVCPlanCode"','167','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','3506',NULL,'VLVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLVCClassCode"','168','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','3508',NULL,'VLVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLVCCTier"','169','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3510',NULL,'VLVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLVCOtherIns"','170','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3540',NULL,'VLVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLVCEmpWaiver"','171','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3570',NULL,'VLVC Emp Waiver',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLVCDepWaiver"','172','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3600',NULL,'VLVC Dep Waiver',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLVCOtherInsType"','173','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3630',NULL,'VLVC Other Ins Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDNGrpAcctNo"','174','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3660',NULL,'VDN Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDNEffDate"','175','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','3690',NULL,'VDN Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDNPlanCode"','176','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','3700',NULL,'VDN Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDNClassCode"','177','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','3702',NULL,'VDN Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDNCvg"','178','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3704',NULL,'VDN Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDNCovTier"','179','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3734',NULL,'VDN Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDNOtherIns"','180','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3764',NULL,'VDN Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDMOGrpAcctNo"','181','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3794',NULL,'VDMO Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDMOEffDate"','182','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','3824',NULL,'VDMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDMOPlanCode"','183','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3834',NULL,'VDMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDMOClassCode"','184','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3864',NULL,'VDMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDMOCvg"','185','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3894',NULL,'VDMO Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDMOCovTier"','186','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3924',NULL,'VDMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVDMOPCP"','187','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3954',NULL,'VDMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFGrpAcctNo"','188','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','3984',NULL,'VLIF Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFEffDate"','189','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4014',NULL,'VLIF Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFPlanCode"','190','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','4024',NULL,'VLIF Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFClassCode"','191','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','4026',NULL,'VLIF Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFCvg"','192','(''UA''=''Q,'')','AZJTDT0000K2','100','D','02','4028',NULL,'VLIF Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFVADDOption"','193','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4128',NULL,'VLIF VADD Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVWIGrpAcctNo"','194','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4158',NULL,'VWI Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVWIEffDAte"','195','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4188',NULL,'VWI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVWIPlanCode"','196','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','4198',NULL,'VWI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVWClassCode"','197','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','4200',NULL,'VWI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVWCvg"','198','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4202',NULL,'VWI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVWIBenAmt"','199','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4232',NULL,'VWI Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVWIElimPeriod"','200','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4262',NULL,'VWI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVWIBenfitPct"','201','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4272',NULL,'VWI Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDGrpAcctNo"','202','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4282',NULL,'VLTD Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDEffDAte"','203','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4312',NULL,'VLTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDPlanCode"','204','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','4322',NULL,'VLTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDClassCode"','205','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','4324',NULL,'VLTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDCvg"','206','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4326',NULL,'VLTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDBenDuration"','207','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4356',NULL,'VLTD Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDBenAmt"','208','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4386',NULL,'VLTD Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDElimPeriod"','209','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4416',NULL,'VLTD Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLTDBenPct"','210','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4426',NULL,'VLTD Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTADACCNo"','211','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4436',NULL,'STAD Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTADEffDate"','212','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4466',NULL,'STAD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTADPlanCode"','213','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','4476',NULL,'STAD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTADClassCode"','214','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','4478',NULL,'STAD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTADCov"','215','(''UA''=''Q,'')','AZJTDT0000K2','100','D','02','4480',NULL,'STAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonCode"','216','(''UA''=''T,'')','AZJTDT0000K2','2','D','02','4580',NULL,'Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonEffDate"','217','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4582',NULL,'Reason Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpComments"','218','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','4592',NULL,'Mbr Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASOInd"','219','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4642',NULL,'ASO Indicator Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFESmoker"','220','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4643',NULL,'VLIF Emp Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFSpsSmoker"','221','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4644',NULL,'VLIF Spouse Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVLIFSpsDOB"','222','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4645',NULL,'VLIF Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFName1"','223','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','4655',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLName1"','224','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','4705',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMName1"','225','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4755',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender1"','226','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4756',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB1"','227','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4757',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship"','228','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4767',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudent1"','229','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4768',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCovInd1"','230','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4769',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPCP1"','231','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4779',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFName2"','232','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','4809',NULL,'Dep 2 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLName2"','233','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','4859',NULL,'Dep 2 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMName2"','234','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4909',NULL,'Dep 2 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender2"','235','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4910',NULL,'Dep 2 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB2"','236','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4911',NULL,'Dep 2 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship2"','237','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4921',NULL,'Dep 2 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudent2"','238','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','4922',NULL,'Dep 2 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCovInd2"','239','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','4923',NULL,'Dep 2 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPCP2"','240','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','4933',NULL,'Dep 2 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFName3"','241','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','4963',NULL,'Dep 3 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLName3"','242','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','5013',NULL,'Dep 3 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMName3"','243','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5063',NULL,'Dep 3 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender3"','244','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5064',NULL,'Dep 3 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB3"','245','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','5065',NULL,'Dep 3 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship3"','246','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5075',NULL,'Dep 3 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudent3"','247','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5076',NULL,'Dep 3 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCovInd3"','248','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','5077',NULL,'Dep 3 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPCP3"','249','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','5087',NULL,'Dep 3 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFName4"','250','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','5117',NULL,'Dep 4 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLName4"','251','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','5167',NULL,'Dep 4 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMName4"','252','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5217',NULL,'Dep 4 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender4"','253','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5218',NULL,'Dep 4 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB4"','254','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','5219',NULL,'Dep 4 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship4"','255','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5229',NULL,'Dep 4 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudent4"','256','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5230',NULL,'Dep 4 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCovInd4"','257','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','5231',NULL,'Dep 4 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPCP4"','258','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','5241',NULL,'Dep 4 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFName5"','259','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','5271',NULL,'Dep 5 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLName"','260','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','5321',NULL,'Dep 5 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMName5"','261','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5371',NULL,'Dep 5 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender5"','262','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5372',NULL,'Dep 5 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB5"','263','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','5373',NULL,'Dep 5 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship5"','264','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5383',NULL,'Dep 5 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudent5"','265','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5384',NULL,'Dep 5 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCovInd5"','266','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','5385',NULL,'Dep 5 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPCP5"','267','(''UA''=''T,'')','AZJTDT0000K2','30','D','02','5395',NULL,'Dep 5 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFName6"','268','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','5425',NULL,'Dep 6 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLName6"','269','(''UA''=''T,'')','AZJTDT0000K2','50','D','02','5475',NULL,'Dep 6 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMName6"','270','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5525',NULL,'Dep 6 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender6"','271','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5526',NULL,'Dep 6 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDOB6"','272','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','5527',NULL,'Dep 6 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship6"','273','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5537',NULL,'Dep 6 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStudent6"','274','(''UA''=''T,'')','AZJTDT0000K2','1','D','02','5538',NULL,'Dep 6 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCovInd6"','275','(''UA''=''T,'')','AZJTDT0000K2','10','D','02','5539',NULL,'Dep 6 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPCP6"','276','(''UA''=''T'')','AZJTDT0000K2','30','D','02','5549',NULL,'Dep 6 DHMO PCP',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW33\Downloads\V10\Exports\TECHI\EmployeeHistoryExport\ACTIVEOE_ELFGEDIT2C_20180315.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'OE','201601209','EMPEXPORT','ACTIVEOE',NULL,'ELFGEDIT2C',NULL,NULL,NULL,'201601209',NULL,NULL,'201510221',NULL,NULL,NULL,'201510221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW33\Downloads\V10\Exports\TECHI\EmployeeHistoryExport\PASSIVEOE_ELFGEDIT2C_20180315.txt',NULL,'Null','N','8G9XQ,CYXVZ,Y0D25,VBSKH,W1EIB,VBDT5,W1EL1',NULL,NULL,NULL,'OE','201901019','EMPEXPORT','PASSIVEOE',NULL,'ELFGEDIT2C',NULL,NULL,NULL,'201812099',NULL,NULL,'201812011',NULL,'','','201812311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW33\Downloads\V10\Exports\TECHI\EmployeeHistoryExport\ELFGEDIT2C_20180718.txt',NULL,'Null','N','8G9XQ,CYXVZ,VBDT5,VBSKH,W1EIB,W1EL1,Y0D25',NULL,NULL,NULL,'Lincoln Fina - wkly Mon 7:30p','201807181','EMPEXPORT','ELFGEDIT2C','Jul 18 2018 11:30AM','ELFGEDIT2C',NULL,NULL,NULL,'201912099','Jul 18 2018 12:00AM','Dec 30 1899 12:00AM','201911251','683','','','201806201',dbo.fn_GetTimedKey(),NULL,'ULTI_WPTECHI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW33\Downloads\V10\Exports\TECHI\EmployeeHistoryExport\TEST_ELFGEDIT2C_20180913.txt',NULL,'','','',NULL,NULL,NULL,'TEST','201809131','EMPEXPORT','TEST','Sep 13 2018  3:13PM','ELFGEDIT2C',NULL,NULL,NULL,'201809131','Sep 13 2018 12:00AM','Dec 30 1899 12:00AM','201808301','727','','','201808301',dbo.fn_GetTimedKey(),NULL,'ULTI_WPTECHI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','ExportDescription','C','Lincoln EDI file V2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','InitialSort','C','drvESSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','MaxFileLength','C','5780');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','SystemID','V','AZJTDV0040K2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDIT2C','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' WHERE FormatCode = 'ELFGEDIT2C' AND CfgName = 'ExportPath' AND CfgValue IS NULL;
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_ELFGEDIT2C_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_ELFGEDIT2C_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELFGEDIT2C_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELFGEDIT2C','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELFGEDIT2C','D02','dbo.U_dsi_ELFGEDIT2C_drvTbl',NULL);
IF OBJECT_ID('U_dsi_ELFGEDIT2C_depTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELFGEDIT2C_depTbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NULL,
    [depid] char(12) NOT NULL,
    [LName] varchar(100) NULL,
    [MName] varchar(50) NULL,
    [FName] varchar(100) NULL,
    [conSSN] char(11) NULL,
    [conGender] char(1) NULL,
    [cstudent] char(1) NULL,
    [cRel] varchar(1) NOT NULL,
    [cSmoker] varchar(1) NULL,
    [cDoB] datetime NULL,
    [drvrank] int NULL
);
IF OBJECT_ID('U_dsi_ELFGEDIT2C_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELFGEDIT2C_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvActionType] varchar(1) NOT NULL,
    [drvChangeDate] varchar(1) NOT NULL,
    [drvDepChangeDate] varchar(1) NOT NULL,
    [drvTermDate] varchar(10) NULL,
    [drvNameFirst] varchar(8000) NULL,
    [drvNameLast] varchar(8000) NULL,
    [drvNameMI] varchar(1) NULL,
    [drvESSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] varchar(10) NULL,
    [drvAppSignDate] varchar(10) NULL,
    [drvOccupation] varchar(8000) NULL,
    [drvHrsPerWeek] char(10) NULL,
    [drvSalary] char(10) NULL,
    [drvSalaryCode] varchar(1) NOT NULL,
    [drvSalEffDate] varchar(10) NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZIP] varchar(5) NULL,
    [drvZIPplus] varchar(4) NULL,
    [drvPhoneHome] varchar(50) NULL,
    [drvPhoneBusiness] char(10) NULL,
    [drvBusinessExt] char(5) NULL,
    [drvHireDate] varchar(10) NULL,
    [drvSpsNameFirst] varchar(100) NULL,
    [drvSpsNameLast] varchar(100) NULL,
    [drvSpouseMI] varchar(50) NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvSpouseGender] char(1) NULL,
    [drvSpouseDOB] char(10) NULL,
    [drvSpouseStateOB] varchar(1) NOT NULL,
    [drvEmpStateOfBirth] varchar(1) NOT NULL,
    [drvMaritialStat] varchar(1) NOT NULL,
    [drvRehireDate] varchar(10) NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvUnionFlag] varchar(1) NOT NULL,
    [drvExemptFlag] varchar(1) NOT NULL,
    [drvHlthPlanDate] varchar(1) NOT NULL,
    [drvPriBenFName] varchar(1) NOT NULL,
    [drvPriBenLName] varchar(1) NOT NULL,
    [drvPriBenMName] varchar(1) NOT NULL,
    [drvPriBenRelation] varchar(1) NOT NULL,
    [drvPriBenAdd1] varchar(1) NOT NULL,
    [drvPriBenAdd2] varchar(1) NOT NULL,
    [drvPriBenCity] varchar(1) NOT NULL,
    [drvPriBenST] varchar(1) NOT NULL,
    [drvPriBenZIP] varchar(1) NOT NULL,
    [drvPriBenZIPplus] varchar(1) NOT NULL,
    [drvPriBenSSN] varchar(1) NOT NULL,
    [drvCoBenFName] varchar(1) NOT NULL,
    [drvCoBenLName] varchar(1) NOT NULL,
    [drvCoBenMName] varchar(1) NOT NULL,
    [drvCoBenRelation] varchar(1) NOT NULL,
    [drvCoBenAdd1] varchar(1) NOT NULL,
    [drvCoBenAdd2] varchar(1) NOT NULL,
    [drvCoBenCity] varchar(1) NOT NULL,
    [drvCoBenST] varchar(1) NOT NULL,
    [drvCoBenZIP] varchar(1) NOT NULL,
    [drvCoBenZIPplus] varchar(1) NOT NULL,
    [drvCoBenSSN] varchar(1) NOT NULL,
    [drvBenComments] varchar(1) NOT NULL,
    [drvAccPolicyNo] varchar(12) NULL,
    [drvAccBLOCAcctNo] varchar(7) NULL,
    [drvAccSortGrp] varchar(1) NOT NULL,
    [drvAccEffDate] varchar(10) NULL,
    [drvAccPlanCode] varchar(11) NULL,
    [drvAccClassCode] varchar(1) NULL,
    [drvAccTierCode] varchar(21) NULL,
    [drvHealthAssTier] varchar(1) NOT NULL,
    [drvHospitalTier] varchar(1) NOT NULL,
    [drvAccDisabilityAmt] varchar(1) NOT NULL,
    [drvAccDITier] varchar(1) NOT NULL,
    [drvAccDIBenPeriod] varchar(1) NOT NULL,
    [drvAccDIElimPeriod] varchar(1) NOT NULL,
    [drvAccSickDisAmt] varchar(1) NOT NULL,
    [drvAccSickTier] varchar(1) NOT NULL,
    [drvAccSickDIAmt] varchar(1) NOT NULL,
    [drvAccSickDIElimPeriod] varchar(1) NOT NULL,
    [drvCIPolicyNo] varchar(12) NULL,
    [drvCIBLOCAccNoSortGrp] varchar(7) NULL,
    [drvCIEffDate] varchar(1) NOT NULL,
    [drvCIPlanCode] varchar(1) NULL,
    [drvCIClassCode] varchar(1) NULL,
    [drvEEPrinAmtApproved] varchar(30) NULL,
    [drvEEPrinAmtPending] varchar(1) NOT NULL,
    [drvSPPrinAmtApproved] varchar(30) NULL,
    [drvSPPrinAmtPending] varchar(1) NOT NULL,
    [drvCHPrinAmtApproved] varchar(30) NULL,
    [drvCHPrinAmtPending] varchar(1) NOT NULL,
    [drvEEHeartAmtApproved] varchar(30) NULL,
    [drvEEHeartAmtPending] varchar(1) NOT NULL,
    [drvSPHeartAmtApproved] varchar(30) NULL,
    [drvSPHeartAmtPending] varchar(1) NOT NULL,
    [drvCHHeartAmtApproved] varchar(30) NULL,
    [drvCHHeartAmtPending] varchar(1) NOT NULL,
    [drvEECanAmtApproved] varchar(30) NULL,
    [drvEECanAmtPending] varchar(1) NOT NULL,
    [drvSPCanAmtApproved] varchar(30) NULL,
    [drvSPCanAmtPending] varchar(1) NOT NULL,
    [drvCHCanAmtApproved] varchar(30) NULL,
    [drvCHCanAmtPending] varchar(1) NOT NULL,
    [drvEEOrganAmtApproved] varchar(30) NULL,
    [drvEEOrganAmtPending] varchar(1) NOT NULL,
    [drvSPOrganAmtApproved] varchar(30) NULL,
    [drvSPOrganAmtPending] varchar(1) NOT NULL,
    [drvCHOrganAmtApproved] varchar(30) NULL,
    [drvCHOrganAmtPending] varchar(1) NOT NULL,
    [drvEEQualAmtApproved] varchar(30) NULL,
    [drvEEQualAmtPending] varchar(1) NOT NULL,
    [drvSPQualAmtApproved] varchar(30) NULL,
    [drvSPQualAmtPending] varchar(1) NOT NULL,
    [drvCHQualAmtApproved] varchar(30) NULL,
    [drvCHQualAmtPending] varchar(1) NOT NULL,
    [drvCHCatAmtApproved] varchar(30) NULL,
    [drvCHCatAmtPending] varchar(1) NOT NULL,
    [drvEETreatmentCare] varchar(1) NOT NULL,
    [drvSPTreatmentCare] varchar(1) NOT NULL,
    [drvCHTreatmentCare] varchar(1) NOT NULL,
    [drvEEDI] varchar(1) NOT NULL,
    [drvSPDI] varchar(1) NOT NULL,
    [drvEEAcc] varchar(30) NULL,
    [drvSPAcc] varchar(30) NULL,
    [drvCHAcc] varchar(30) NULL,
    [drvEEOccHIV] varchar(1) NOT NULL,
    [drvLifeGrpAcctNo] varchar(7) NULL,
    [drvLifeEffDate] varchar(10) NULL,
    [drvLifePlanCode] varchar(1) NULL,
    [drvLifeClassCode] varchar(1) NULL,
    [drvLiveCvg] varchar(19) NULL,
    [drvWIGrpAcctNo] varchar(7) NULL,
    [drvWIEffDate] varchar(10) NULL,
    [drvWIPlanCode] varchar(1) NULL,
    [drvWIClassCode] varchar(1) NULL,
    [drvWICvg] varchar(4) NULL,
    [drvLTDGrpAcctNo] varchar(7) NULL,
    [drvLTDEffDate] varchar(10) NULL,
    [drvLTDPlanCode] varchar(1) NULL,
    [drvLTDClassCode] varchar(1) NULL,
    [drvLTDCvg] varchar(15) NULL,
    [drvDentGrpAcctNo] varchar(7) NULL,
    [drvDentEffDate] varchar(10) NULL,
    [drvDentPlanCode] varchar(1) NULL,
    [drvDentClassCode] varchar(1) NULL,
    [drvDentCvg] varchar(3) NULL,
    [drvDentCvgTier] varchar(1) NOT NULL,
    [drvDentOtherIns] varchar(1) NOT NULL,
    [drvDHMOAcctNo] varchar(7) NULL,
    [drvDHMOEffDate] varchar(10) NULL,
    [drvDHMOPlanCode] varchar(1) NULL,
    [drvDHMOClassCode] varchar(1) NULL,
    [drvDHMOCvg] varchar(4) NULL,
    [drvDHMOTier] varchar(1) NOT NULL,
    [drvDHMOPCP] varchar(1) NOT NULL,
    [drvLVCAcctNo] varchar(1) NOT NULL,
    [drvLVCEffDate] varchar(1) NOT NULL,
    [drvLVCPlanCode] varchar(1) NOT NULL,
    [drvLVCClassCode] varchar(1) NOT NULL,
    [drvLVCCTier] varchar(1) NOT NULL,
    [drvLVCOtherIns] varchar(1) NOT NULL,
    [drvLVCEmpWaiver] varchar(1) NOT NULL,
    [drvLVCDepWaiver] varchar(1) NOT NULL,
    [drvLVCOtherInsType] varchar(1) NOT NULL,
    [drvVLVCAcctNo] varchar(1) NOT NULL,
    [drvVLVCEffDate] varchar(1) NOT NULL,
    [drvVLVCPlanCode] varchar(1) NOT NULL,
    [drvVLVCClassCode] varchar(1) NOT NULL,
    [drvVLVCCTier] varchar(1) NOT NULL,
    [drvVLVCOtherIns] varchar(1) NOT NULL,
    [drvVLVCEmpWaiver] varchar(1) NOT NULL,
    [drvVLVCDepWaiver] varchar(1) NOT NULL,
    [drvVLVCOtherInsType] varchar(1) NOT NULL,
    [drvVDNGrpAcctNo] varchar(7) NULL,
    [drvVDNEffDate] varchar(10) NULL,
    [drvVDNPlanCode] varchar(1) NULL,
    [drvVDNClassCode] varchar(1) NULL,
    [drvVDNCvg] varchar(3) NULL,
    [drvVDNCovTier] varchar(1) NOT NULL,
    [drvVDNOtherIns] varchar(1) NOT NULL,
    [drvVDNNameIns1] varchar(1) NOT NULL,
    [drvVDNInsCo1] varchar(1) NOT NULL,
    [drvVDNEmployer1] varchar(1) NOT NULL,
    [drvVDNInsPlan1] varchar(1) NOT NULL,
    [drvVDNNameIns2] varchar(1) NOT NULL,
    [drvVDNInsCo2] varchar(1) NOT NULL,
    [drvVDNEmployer2] varchar(1) NOT NULL,
    [drvVDNInsPlan2] varchar(1) NOT NULL,
    [drvVDNEmpWaiver] varchar(1) NOT NULL,
    [drvDepWaiver] varchar(1) NOT NULL,
    [drvVDNOtherInsType] varchar(1) NOT NULL,
    [drvVDMOGrpAcctNo] varchar(1) NOT NULL,
    [drvVDMOEffDate] varchar(1) NOT NULL,
    [drvVDMOPlanCode] varchar(1) NOT NULL,
    [drvVDMOClassCode] varchar(1) NOT NULL,
    [drvVDMOCvg] varchar(1) NOT NULL,
    [drvVDMOCovTier] varchar(1) NOT NULL,
    [drvVDMOPCP] varchar(1) NOT NULL,
    [drvVLIFGrpAcctNo] varchar(7) NULL,
    [drvVLIFEffDate] varchar(10) NULL,
    [drvVLIFPlanCode] varchar(1) NULL,
    [drvVLIFClassCode] varchar(1) NULL,
    [drvVLIFCvg] varchar(222) NULL,
    [drvVLIFVADDOption] varchar(1) NOT NULL,
    [drvVWIGrpAcctNo] varchar(1) NOT NULL,
    [drvVWIEffDAte] varchar(1) NOT NULL,
    [drvVWIPlanCode] varchar(1) NOT NULL,
    [drvVWClassCode] varchar(1) NOT NULL,
    [drvVWCvg] varchar(1) NOT NULL,
    [drvVWIBenAmt] varchar(1) NOT NULL,
    [drvVWIElimPeriod] varchar(1) NOT NULL,
    [drvVWIBenfitPct] varchar(1) NOT NULL,
    [drvVLTDGrpAcctNo] varchar(1) NOT NULL,
    [drvVLTDEffDate] varchar(1) NOT NULL,
    [drvVLTDPlanCode] varchar(1) NOT NULL,
    [drvVLTDClassCode] varchar(1) NOT NULL,
    [drvVLTDCvg] varchar(1) NOT NULL,
    [drvVLTDBenDuration] varchar(1) NOT NULL,
    [drvVLTDBenAmt] varchar(1) NOT NULL,
    [drvVLTDElimPeriod] varchar(1) NOT NULL,
    [drvVLTDBenPct] varchar(1) NOT NULL,
    [drvSTADACCNo] varchar(7) NULL,
    [drvSTADEffDate] varchar(10) NULL,
    [drvSTADPlanCode] varchar(1) NULL,
    [drvSTADClassCode] varchar(1) NULL,
    [drvSTADCov] varchar(111) NULL,
    [drvReasonCode] varchar(1) NOT NULL,
    [drvReasonEffDate] varchar(1) NOT NULL,
    [drvEmpComments] varchar(1) NOT NULL,
    [drvASOInd] varchar(1) NOT NULL,
    [drvVLIFESmoker] varchar(1) NOT NULL,
    [drvVLIFSpsSmoker] varchar(1) NOT NULL,
    [drvVLIFSpsDOB] char(10) NULL,
    [drvDepFName1] varchar(1) NOT NULL,
    [drvDepLName1] varchar(1) NOT NULL,
    [drvDepMName1] varchar(1) NOT NULL,
    [drvDepGender1] varchar(1) NOT NULL,
    [drvDepDOB1] varchar(1) NOT NULL,
    [drvDepRelationship] varchar(1) NOT NULL,
    [drvDepStudent1] varchar(1) NOT NULL,
    [drvDepCovInd1] varchar(1) NOT NULL,
    [drvDepPCP1] varchar(1) NOT NULL,
    [drvDepFName2] varchar(1) NOT NULL,
    [drvDepLName2] varchar(1) NOT NULL,
    [drvDepMName2] varchar(1) NOT NULL,
    [drvDepGender2] varchar(1) NOT NULL,
    [drvDepDOB2] varchar(1) NOT NULL,
    [drvDepRelationship2] varchar(1) NOT NULL,
    [drvDepStudent2] varchar(1) NOT NULL,
    [drvDepCovInd2] varchar(1) NOT NULL,
    [drvDepPCP2] varchar(1) NOT NULL,
    [drvDepFName3] varchar(1) NOT NULL,
    [drvDepLName3] varchar(1) NOT NULL,
    [drvDepMName3] varchar(1) NOT NULL,
    [drvDepGender3] varchar(1) NOT NULL,
    [drvDepDOB3] varchar(1) NOT NULL,
    [drvDepRelationship3] varchar(1) NOT NULL,
    [drvDepStudent3] varchar(1) NOT NULL,
    [drvDepCovInd3] varchar(1) NOT NULL,
    [drvDepPCP3] varchar(1) NOT NULL,
    [drvDepFName4] varchar(1) NOT NULL,
    [drvDepLName4] varchar(1) NOT NULL,
    [drvDepMName4] varchar(1) NOT NULL,
    [drvDepGender4] varchar(1) NOT NULL,
    [drvDepDOB4] varchar(1) NOT NULL,
    [drvDepRelationship4] varchar(1) NOT NULL,
    [drvDepStudent4] varchar(1) NOT NULL,
    [drvDepCovInd4] varchar(1) NOT NULL,
    [drvDepPCP4] varchar(1) NOT NULL,
    [drvDepFName5] varchar(1) NOT NULL,
    [drvDepLName] varchar(1) NOT NULL,
    [drvDepMName5] varchar(1) NOT NULL,
    [drvDepGender5] varchar(1) NOT NULL,
    [drvDepDOB5] varchar(1) NOT NULL,
    [drvDepRelationship5] varchar(1) NOT NULL,
    [drvDepStudent5] varchar(1) NOT NULL,
    [drvDepCovInd5] varchar(1) NOT NULL,
    [drvDepPCP5] varchar(1) NOT NULL,
    [drvDepFName6] varchar(1) NOT NULL,
    [drvDepLName6] varchar(1) NOT NULL,
    [drvDepMName6] varchar(1) NOT NULL,
    [drvDepGender6] varchar(1) NOT NULL,
    [drvDepDOB6] varchar(1) NOT NULL,
    [drvDepRelationship6] varchar(1) NOT NULL,
    [drvDepStudent6] varchar(1) NOT NULL,
    [drvDepCovInd6] varchar(1) NOT NULL,
    [drvDepPCP6] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ELFGEDIT2C_volADDcovTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELFGEDIT2C_volADDcovTbl] (
    [ceeid] char(12) NOT NULL,
    [ccoid] char(5) NOT NULL,
    [dcode] char(5) NOT NULL,
    [csort] varchar(1) NOT NULL,
    [ccov] varchar(37) NULL
);
IF OBJECT_ID('U_dsi_ELFGEDIT2C_volcovTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELFGEDIT2C_volcovTbl] (
    [ceeid] char(12) NOT NULL,
    [ccoid] char(5) NOT NULL,
    [dcode] char(5) NOT NULL,
    [csort] varchar(1) NOT NULL,
    [ccov] varchar(37) NULL
);
IF OBJECT_ID('U_ELFGEDIT2C_EEList') IS NULL
CREATE TABLE [dbo].[U_ELFGEDIT2C_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELFGEDIT2C_File') IS NULL
CREATE TABLE [dbo].[U_ELFGEDIT2C_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(6000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELFGEDIT2C]
 @systemid varchar(12) = ''
AS
Begin

/**********************************************************************
Client Name: Tech Industries Management, LLC
Vendor: Lincoln Financial Group EDI Enrollment File for Life and LTD (v1)
Created By: Syed Salehin
Business Analyst: Kim Jimenez
Create Date: 03/22/2018
Service Request Number: PSA Project# TEC1003-2017-00179489

Changes:
MM/DD/YYYY    NAME HERE     SF 09999999              Comments Here

_dsi_usp_ExportRipout 'ELFGEDIT2C','Y' 

select * from dbo.U_dsi_Configuration where FormatCode = 'ELFGEDIT2C' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'ELFGEDIT2C'
select * from dbo.U_dsi_Parameters where FormatCode = 'ELFGEDIT2C'

select * from AscDefH where AdhFormatCode = 'ELFGEDIT2C'
select * from AscExp where expFormatCode = 'ELFGEDIT2C'
select * from ascdeff where AdfHeaderSystemID = 'ELFGEDIT2CZ0' order by adfrectype, AdfSetNumber, AdfFieldNumber 

DSI_SP_TESTSWITCHBOX_V2 'ELFGEDIT2C', 'ELFGEDIT2C'
DSI_SP_TESTSWITCHBOX_V2 'ELFGEDIT2C', 'TEST'
DSI_SP_TESTSWITCHBOX_V2 'ELFGEDIT2C', 'ACTIVEOE'
DSI_SP_TESTSWITCHBOX_V2 'ELFGEDIT2C', 'PASSIVEOE'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'ELFGEDIT2C' AND CfgName = 'TESTING'

**************************/

/*************************************************************************************************
There is a complex case statement in this export when importing data into the drvTbl.
The reason why it exists, is because every cursor, and update statement that has been written to
update the coverage amounts on this export, has resulted in a truncation error on that field.
Changing the size of the variable has had no impact on resolving the truncation error.
This is mostly due to having one deduction codes for each coverage type, for LFG, when LFG
needs all 5 coverage types reported in 1 field.
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
        @ExportFile char(200),
        @PlanDate DATETIME;

    --    Declare @Systemid char(12)
    --    set @Systemid = '6DWPQL0000K0'

    SELECT
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = Exportcode,
        @Exportfile = ExportFile,
        @PlanDate = '20180101'

    FROM dbo.U_Dsi_Parameters
    WHERE SystemID = @SystemID;

-- change variables below as needed
declare @daysstopped int;
declare @useaudit char(1);
declare @includeoe char(1);

declare @showalldeds char(1);
declare @allcomp char(1);
declare @onerecperemp char(1);
declare @showstoppedoe  char(1);
declare @oetype char(1);
set @daysstopped = 30;    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y';    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N';   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N'; -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y';     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y';  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N'; -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F';        -- P or F indicates if this export is for a passive or full(active) oe

-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_ELFGEDIT2C_EELIST
            from dbo.u_ELFGEDIT2C_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T');

end;

--BDM
-- replace ELFGSELMOE with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','GLIFD, GLIFE, GLIFN, STD, LTD, LTDE, LIFEC, LIFEE, LIFES');

IF @ExportCode not like '%OE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@EndDate - @daysstopped);
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate);
END;
IF @ExportCode like '%OE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate);
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate);
END;

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate');    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'PASSIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive');
END;
IF @ExportCode = 'ACTIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active');
END;

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

/*
INSERT INTO dbo.U_dsi_bdm_DepDeductions (dbnformatcode, dbncoid, dbneeid, dbndeprecid, dedeebenamt, dbnbenoption, dbnbenstatus, dbnbenstartdate, dbnbenstopdate, dbndedcode, dbnvalidforexport, deddedcode, deddedtype)
      (select eedformatcode, ee.eedcoid, ee.eedeeid, consystemid, ee.eedbenamt, ee.eedbenoption, ee.eedbenstatus, ee.eedbenstartdate, ee.eedbenstopdate, ee.eeddedcode, ee.eedvalidforexport, ee.eeddedcode, ee.deddedtype
from empded ed join emppers with (nolock) on eepeeid = ed.eedeeid
JOIN dbo.u_dsi_bdm_EmpDeductions ee with (nolock) on ee.eedeeid = ed.eedeeid and ee.eedcoid = ed.eedcoid
    and eedFormatCode = @FormatCode and eedValidForExport = 'Y'
    and ee.eeddedcode = ed.eeddedcode
join contacts with (nolock) on eedDepRecID = consystemid
where ee.eeddedcode = 'SPCI')
*/


--Bundled Benefits
--Employee Voluntary Life to Employee Voluntary AD&D
INSERT INTO dbo.U_dsi_bdm_EmpDeductions (eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, eeddedcode, eedvalidforexport, deddedcode, deddedtype)
     (select eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, 'VADDE', eedvalidforexport, 'VADDE', deddedtype
FROM dbo.U_dsi_bdm_EmpDeductions with (nolock) WHERE eedformatcode = 'ELFGEDIT2C' and eeddedcode = 'LIFEE')

--Spouse Voluntary Life to Spouse Voluntary AD&D
INSERT INTO dbo.U_dsi_bdm_EmpDeductions (eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, eeddedcode, eedvalidforexport, deddedcode, deddedtype)
     (select eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, 'VADDS', eedvalidforexport, 'VADDS', deddedtype
FROM dbo.U_dsi_bdm_EmpDeductions with (nolock) WHERE eedformatcode = 'ELFGEDIT2C' and eeddedcode = 'LIFES')

--Child Voluntary Life to Child Voluntary AD&D
INSERT INTO dbo.U_dsi_bdm_EmpDeductions (eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, eeddedcode, eedvalidforexport, deddedcode, deddedtype)
     (select eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, 'VADDC', eedvalidforexport, 'VADDC', deddedtype
FROM dbo.U_dsi_bdm_EmpDeductions with (nolock) WHERE eedformatcode = 'ELFGEDIT2C' and eeddedcode = 'LIFEC')



EXEC dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

--Make Sure Dependent Amount matches the EE Amount:
update dbo.U_dsi_bdm_BenCalculationAmounts
set BcaBenAmtCalc = ee.amt
from dbo.U_dsi_bdm_BenCalculationAmounts
join (select bcaeeid eeid, bcacoid coid, bcadedcode dedcode, BcaBenAmtCalc amt
    from dbo.U_dsi_bdm_BenCalculationAmounts
    where BcaFormatCode = @FormatCode and BcaDepRecID is null) ee on ee.eeid = bcaeeid and ee.coid = BcaCoID and ee.dedcode = BcaDedCode and ee.amt <> BcaBenAmtCalc
where BcaDepRecID is not null

/*
Update dbo.u_dsi_bdm_BenCalculationAmounts
    set bcaBenAmtCalc = lf.amtcalc
from dbo.u_dsi_bdm_BenCalculationAmounts
join (select distinct bcaeeid eeid, bcacoid coid, bcaBenAmtCalc amtcalc
    from dbo.u_dsi_bdm_BenCalculationAmounts
    where bcaFormatCode = @FormatCode and bcaDedCode in ('LIFEE')) lf on lf.eeid = bcaeeid and lf.coid = bcacoid
where bcaFormatCode = @FormatCode and bcadedcode in ('VADDE')

Update dbo.u_dsi_bdm_BenCalculationAmounts
    set bcaBenAmtCalc = lf.amtcalc
from dbo.u_dsi_bdm_BenCalculationAmounts
join (select distinct bcaeeid eeid, bcacoid coid, bcaBenAmtCalc amtcalc
    from dbo.u_dsi_bdm_BenCalculationAmounts
    where bcaFormatCode = @FormatCode and bcaDedCode in ('LIFES')) lf on lf.eeid = bcaeeid and lf.coid = bcacoid
where bcaFormatCode = @FormatCode and bcadedcode in ('VADDS')
*/

-- Step20 Clean up eelist if needed to only include employees with deductions
            delete dbo.u_ELFGEDIT2C_eelist
            from dbo.u_ELFGEDIT2C_eelist a
            where not exists(select 1 from U_dsi_bdm_EmpDeductions
                            where a.xeeid = eedeeid
                            and a.xcoid = eedcoid
                            and eedformatcode = @formatcode
                            and eedvalidforexport = 'Y');

-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_ELFGEDIT2C_EELIST
            from dbo.u_ELFGEDIT2C_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T');

            delete dbo.u_ELFGEDIT2C_eelist
            from dbo.u_ELFGEDIT2C_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ELFGEDIT2C_eelist b where a.xeeid = b.xeeid
            having count(*) > 1);
end;

--Remove Test employees
delete dbo.u_ELFGEDIT2C_eelist 
from dbo.u_ELFGEDIT2C_eelist 
--join empcomp on eeccoid = xcoid and eeceeid = xeeid 
join emppers on eepeeid = xeeid 
where eepnamelast = 'TEST'

--Remove Employee type 'TEST' --Per PA-0000204989
delete dbo.u_ELFGEDIT2C_eelist 
from dbo.u_ELFGEDIT2C_eelist 
join empcomp on eeccoid = xcoid and eeceeid = xeeid 
--join emppers on eepeeid = xeeid 
where eeceetype = 'TES'

--Remove Part-time employees --Per PA-0000204989
delete dbo.u_ELFGEDIT2C_eelist 
from dbo.u_ELFGEDIT2C_eelist 
join empcomp on eeccoid = xcoid and eeceeid = xeeid 
--join emppers on eepeeid = xeeid 
where eecfulltimeorparttime = 'P'

--Remove owners Charlie Newell and Henry Newell --Per PA-0000204989
delete dbo.u_ELFGEDIT2C_eelist 
from dbo.u_ELFGEDIT2C_eelist 
--join empcomp on eeccoid = xcoid and eeceeid = xeeid 
join emppers on eepeeid = xeeid 
where eepnamelast = 'NEWELL' and eepnamefirst in ('Charlie','Henry')
       

--use this section of code up above the DRV table for Employees:
--select * from codes where codtable = 'relation'
if object_id('U_dsi_ELFGEDIT2C_depTbl') is not null
    drop table dbo.U_dsi_ELFGEDIT2C_depTbl;

select distinct
    drveeid = dbneeid,
    drvcoid = dbncoid,
    depid = dbndeprecid,
    LName = connamelast,
    MName = connamemiddle,
    FName = connamefirst,
    conSSN = conssn,
    conGender = conGender,
    cstudent = conisstudent,
    cRel = case when conRelationship in ('SPS','DP') then 'S'
--select * from codes where codtable = 'relation'
            else 'C' end,
    cSmoker = conissmoker,
    cDoB = conDateofBirth,
    drvrank = null

into dbo.U_dsi_ELFGEDIT2C_depTbl
from dbo.u_dsi_bdm_DepDeductions
    join contacts on dbndeprecid = consystemid
where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y';

--select * from dbo.U_dsi_ELFGEDIT2C_depTbl

with mytemptable
as
(
select *, row_number()over(partition by drveeid order by cDoB) as rnk
from dbo.U_dsi_ELFGEDIT2C_depTbl
where drvrank is null
)
update mytemptable
set drvrank = '0' + CAST(rnk AS VARCHAR)
Where drvrank is null;


--Syed Salehin 04/16/18: Use EedBenAmt instead of bcaBenAmtCalc for LIFEC, LIFES, VADDE, VADDS, and VADDC:
update dbo.u_dsi_bdm_BenCalculationAmounts 
set bcaBenAmtCalc = eedbenamt
--select bcaBenAmtCalc,eedbenamt,eeddedcode,* 
from U_dsi_bdm_EmpDeductions  
    join dbo.u_dsi_bdm_BenCalculationAmounts on eedeeid = bcaeeid and eedcoid = bcacoid
        and eedFormatCode = bcaFormatCode and eeddedcode = bcadedcode
        and BcaDepRecID is null
  where eeddedcode IN ('LIFEC','LIFES','VADDE','VADDS','VADDC')
    and eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
    and isnull(bcaBenAmtCalc,0) <> eedbenamt




--vol life coverages
if object_id('dbo.U_dsi_ELFGEDIT2C_volcovTbl') is not null
  drop table dbo.U_dsi_ELFGEDIT2C_volcovTbl;

select
    ceeid = eedeeid,
    ccoid = eedcoid,
    dcode = eeddedcode,
    csort = case when eeddedcode in ('LIFEE') then '1'
                 when eeddedcode in ('LIFES') then '2'
                 when eeddedcode in ('LIFEC') then '3'
                else '9' end,
    ccov = case 
            when eeddedcode in ('LIFEE') then 'VLI-'+ substring(cast(bcaBenAmtCalc as varchar),1,charindex('.',bcaBenAmtCalc)-1) + ', '
            when eeddedcode in ('LIFES') then 'VSLI-'+ substring(cast(bcaBenAmtCalc as varchar),1,charindex('.',bcaBenAmtCalc)-1) + ', '
            when eeddedcode in ('LIFEC') then 'VCLI-'+ substring(cast(bcaBenAmtCalc as varchar),1,charindex('.',bcaBenAmtCalc)-1) + ', '
            else '' end

  into dbo.U_dsi_ELFGEDIT2C_volcovTbl
  from U_dsi_bdm_EmpDeductions  with (nolock)
    join dbo.u_dsi_bdm_BenCalculationAmounts on eedeeid = bcaeeid and eedcoid = bcacoid
        and eedFormatCode = bcaFormatCode and eeddedcode = bcadedcode
        and BcaDepRecID is null
  where eeddedcode IN ('LIFEE','LIFEC','LIFES')
    and eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
  order by ceeid, ccoid, csort;

--select * from U_dsi_ELFGEDIT2C_volcovTbl

if object_id('dbo.U_dsi_ELFGEDIT2C_volADDcovTbl') is not null
  drop table dbo.U_dsi_ELFGEDIT2C_volADDcovTbl;

select
    ceeid = eedeeid,
    ccoid = eedcoid,
    dcode = eeddedcode,
    csort = case when eeddedcode in ('VADDE') then '1'
                when eeddedcode in ('VADDS') then '2'
                when eeddedcode in ('VADDC') then '3'
                else '9' end,
    ccov = case when eeddedcode in ('VADDE') then 'VAD-'+ substring(cast(bcaBenAmtCalc as varchar),1,charindex('.',bcaBenAmtCalc)-1) + ', '
            when eeddedcode in ('VADDS') then 'VSAD-'+ substring(cast(bcaBenAmtCalc as varchar),1,charindex('.',bcaBenAmtCalc)-1) + ', '
            when eeddedcode in ('VADDC') then 'VCLI-'+ substring(cast(bcaBenAmtCalc as varchar),1,charindex('.',bcaBenAmtCalc)-1) + ', '
            else '' end

  into dbo.U_dsi_ELFGEDIT2C_volADDcovTbl
  from U_dsi_bdm_EmpDeductions  with (nolock)
    join dbo.u_dsi_bdm_BenCalculationAmounts on eedeeid = bcaeeid and eedcoid = bcacoid
        and eedFormatCode = bcaFormatCode and eeddedcode = bcadedcode
        and BcaDepRecID is null
  where eeddedcode IN ('VADDE','VADDS','VADDC')
    and eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
  order by ceeid, ccoid, csort;

--select * from U_dsi_ELFGEDIT2C_volcovTbl

-- Populate Source for Employees

if object_id('U_dsi_ELFGEDIT2C_drvTbl') is not null
  drop table dbo.U_dsi_ELFGEDIT2C_drvTbl;

-- EE Detail

  select distinct
    drvEEID = xEEID,
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below
    drvActionType = case when eecEmplStatus = 'T' then 'T' else '' end,
    drvChangeDate =  '',
    drvDepChangeDate = '',
    drvTermDate = case when eecEmplStatus = 'T' then CONVERT(varchar(10), eecDateOfTermination, 101) else '' end,
    drvNameFirst = replace(rtrim(eepNameFirst),',',''),
    drvNameLast = replace(rtrim(eepNameLast),',',''),
    drvNameMI = substring(eepNameMiddle,1,1),
    drvESSN = eepSSN,
    drvGender = eepGender,
    drvDOB = CONVERT(varchar(10), eepDateOfBirth, 101),
    drvAppSignDate = case when eecDateOfLastHire < @PlanDate then CONVERT(varchar(10),@PlanDate, 101) else CONVERT(varchar(10),eecDateOfLastHire, 101) end,    --2/23/17 CONVERT(varchar(10),eecUDField08, 101),--eecDateOfLastHire
    drvOccupation = replace(jbcDesc,',',''),
    drvHrsPerWeek =  case when eecPayPeriod = 'B' then (convert(char(10),convert(numeric(12,2),eecScheduledWorkHrs / 2)))
                        when EecPayPeriod = 'S' then convert(char(10),convert(numeric(12,2),(EecScheduledWorkHrs*24)/52))
                        when EecPayPeriod = 'M' then convert(char(10),convert(numeric(12,2),(EecScheduledWorkHrs*12)/52))
                    else (convert(char(10),convert(numeric(12,2),eecScheduledWorkHrs))) end,
    drvSalary = case when eecSalaryOrHourly = 'S' then (convert(char(10),convert(numeric(12,2),eecAnnSalary))) else (convert(char(10),convert(numeric(12,2),eecHourlyPayRate))) end,
    drvSalaryCode = case when eecSalaryOrHourly = 'S' then 'A' else 'H' end,
    drvSalEffDate = CASE WHEN jh.saleffdate < eecdateoflasthire THEN CONVERT(varchar(10), eecdateoflasthire, 101) ELSE CONVERT(varchar(10), coalesce(jh.saleffdate,eecdateoflasthire), 101) END,
    drvAddress1 = rtrim(replace(replace(replace(eepAddressLine1,',',''),char(10),''),char(13),'')),--replace(eepAddressLine1,',',''),
    drvAddress2 = rtrim(replace(replace(replace(eepAddressLine2,',',''),char(10),''),char(13),'')),--replace(eepAddressLine2,',',''),
    drvCity = eepAddressCity,
    drvState = eepAddressState,
    drvZIP = substring(eepAddressZIPCode,1,5),
    drvZIPplus = substring(eepAddressZIPCode,6,4),
    drvPhoneHome = eepPhoneHomeNumber,
    drvPhoneBusiness = eecPhoneBusinessNumber,
    drvBusinessExt = eecPhoneBusinessExt,
    drvHireDate = convert(varchar(10),eecDateOfLastHire,101),
    drvSpsNameFirst = sps.FName,
    drvSpsNameLast = sps.LName,
    drvSpouseMI = sps.MName,
    drvSpouseSSN = sps.conssn,
    drvSpouseGender = sps.conGender,
    drvSpouseDOB = convert(char(10),sps.cDoB,101),
    drvSpouseStateOB = '',
    drvEmpStateOfBirth = '',
    drvMaritialStat = '',
    drvRehireDate = case when eecdateoflasthire>eecdateoforiginalhire then convert(varchar(10),eecdateoflasthire,101) END,
    drvEmail = '',
    drvUnionFlag = '',
    drvExemptFlag = '',
    drvHlthPlanDate = '',--40
    drvPriBenFName = '',
    drvPriBenLName = '',
    drvPriBenMName = '',
    drvPriBenRelation = '',
    drvPriBenAdd1 = '',
    drvPriBenAdd2 = '',
    drvPriBenCity = '',
    drvPriBenST = '',
    drvPriBenZIP = '',
    drvPriBenZIPplus = '',
    drvPriBenSSN = '',
    drvCoBenFName = '',
    drvCoBenLName = '',
    drvCoBenMName = '',
    drvCoBenRelation = '',
    drvCoBenAdd1 = '',
    drvCoBenAdd2 = '',
    drvCoBenCity = '',
    drvCoBenST = '',
    drvCoBenZIP = '',
    drvCoBenZIPplus = '',
    drvCoBenSSN = '',
    drvBenComments = '',
    drvAccPolicyNo = acc.policy,
    drvAccBLOCAcctNo = acc.bloc,
    drvAccSortGrp = '',
    drvAccEffDate = CONVERT(varchar(10),acc.effdate,101),
    drvAccPlanCode = acc.planc,
    drvAccClassCode = acc.class,
    drvAccTierCode = acc.tier,
    drvHealthAssTier = '',
    drvHospitalTier = '',
    drvAccDisabilityAmt = '',
    drvAccDITier = '',
    drvAccDIBenPeriod = '',
    drvAccDIElimPeriod = '',
    drvAccSickDisAmt = '',
    drvAccSickTier = '',
    drvAccSickDIAmt = '',
    drvAccSickDIElimPeriod = '',
    drvCIPolicyNo = CI.policy,
    drvCIBLOCAccNoSortGrp = CI.bloc,
    drvCIEffDate = '',
    drvCIPlanCode = CI.planc,
    drvCIClassCode = CI.class,
    drvEEPrinAmtApproved = cast(CI.Amt as varchar),
    drvEEPrinAmtPending = '',
    drvSPPrinAmtApproved = cast(SPCI.Amt as varchar),
    drvSPPrinAmtPending = '',
    drvCHPrinAmtApproved = cast(CI.ChAmt as varchar),
    drvCHPrinAmtPending = '',
    drvEEHeartAmtApproved = cast(CI.Amt as varchar),
    drvEEHeartAmtPending = '',
    drvSPHeartAmtApproved = cast(SPCI.Amt as varchar),
    drvSPHeartAmtPending = '',
    drvCHHeartAmtApproved = cast(CI.ChAmt as varchar),
    drvCHHeartAmtPending = '',
    drvEECanAmtApproved = cast(CI.Amt as varchar),
    drvEECanAmtPending = '',
    drvSPCanAmtApproved = cast(SPCI.Amt as varchar),
    drvSPCanAmtPending = '',
    drvCHCanAmtApproved = cast(CI.ChAmt as varchar),
    drvCHCanAmtPending = '',
    drvEEOrganAmtApproved = cast(CI.Amt as varchar),
    drvEEOrganAmtPending = '',
    drvSPOrganAmtApproved = cast(SPCI.Amt as varchar),
    drvSPOrganAmtPending = '',
    drvCHOrganAmtApproved = cast(CI.ChAmt as varchar),
    drvCHOrganAmtPending = '',
    drvEEQualAmtApproved = cast(CI.Amt as varchar),
    drvEEQualAmtPending = '',
    drvSPQualAmtApproved = cast(SPCI.Amt as varchar),
    drvSPQualAmtPending = '',
    drvCHQualAmtApproved = cast(CI.ChAmt as varchar),
    drvCHQualAmtPending = '',
    drvCHCatAmtApproved = cast(CI.ChAmt as varchar),
    drvCHCatAmtPending = '',
    drvEETreatmentCare = '',
    drvSPTreatmentCare = '',
    drvCHTreatmentCare = '',
    drvEEDI = '',
    drvSPDI = '',
    drvEEAcc = cast(CI.Amt as varchar),
    drvSPAcc = cast(SPCI.Amt as varchar),
    drvCHAcc = cast(CI.ChAmt as varchar),
    drvEEOccHIV = '',    
--Life and AD&D
    drvLifeGrpAcctNo = ladd.acct,--425893
    drvLifeEffDate = CONVERT(varchar(10),ladd.date, 101),--CONVERT(varchar(10), ladd.date, 101), --< @PlanDate then @PlanDate else CONVERT(varchar(10), ladd.date, 101) end,
    drvLifePlanCode = ladd.planc,
    drvLifeClassCode = ladd.class,
    drvLiveCvg = ladd.cvg,
--Weekly Income --STD--
    drvWIGrpAcctNo = wi.acct,
    drvWIEffDate = case when len(wi.acct) > 0 then CONVERT(varchar(10),wi.startd, 101) else '' end,
    drvWIPlanCode = wi.planc,
    drvWIClassCode = wi.class,
    drvWICvg = wi.cvg,
--LTD
    drvLTDGrpAcctNo = ltd.acct,--'425893'--change this below in the join statement if necessary
    drvLTDEffDate = CONVERT(varchar(10), ltd.date, 101),-- < @PlanDate then @PlanDate else CONVERT(varchar(10), ltd.date, 101) end,
    drvLTDPlanCode = ltd.planc,
    drvLTDClassCode = ltd.class,
    drvLTDCvg = ltd.cvg,
--dental
    drvDentGrpAcctNo = den.acct,
    drvDentEffDate = CONVERT(varchar(10), den.startd, 101),
    drvDentPlanCode = den.planc,
    drvDentClassCode = den.class,
    drvDentCvg = den.cvg,
    drvDentCvgTier = case when den.tier in ('EE','SING') then '1'
                        when den.tier in ('EES','EEDP') then '2'
                        when den.tier in ('EEC') then '3'
                        when den.tier in ('EEF','EEDPF','FAM') then '4'
                    else '' end,
--more dental (n/a)
    drvDentOtherIns = '',
    --drvDentNameIns1 = '',
    --drvDentInsCo1 = '',
    --drvDentEmployer1 = '',
    --drvDentInsPlan1 = '',
    --drvDentNameIns2 = '',
    --drvDentInsCo2 = '',
    --drvDentEmployer2 = '',
    --drvDentInsPlan2 = '',
    --drvDentEmpWaiver = '',
    --drvDentDepWaiver = '',
    --drvDentOtherInsType = '',
--NEW
    drvDHMOAcctNo = dhmo.acct,
    drvDHMOEffDate = CONVERT(varchar(10), dhmo.startd, 101),
    drvDHMOPlanCode = dhmo.planc,
    drvDHMOClassCode = dhmo.class,
    drvDHMOCvg = dhmo.cvg,
    drvDHMOTier = case when dhmo.tier in ('EE') then '1'
                          when dhmo.tier in ('ES') then '2'
                          when dhmo.tier in ('EC') then '3'
                          when dhmo.tier in ('EF') then '4'
                    else '' end,
    drvDHMOPCP = '',

    drvLVCAcctNo = '',
    drvLVCEffDate = '',
    drvLVCPlanCode = '',
    drvLVCClassCode = '',
    drvLVCCTier = '',
    drvLVCOtherIns = '',
    drvLVCEmpWaiver = '',
    drvLVCDepWaiver = '',
    drvLVCOtherInsType = '',
    drvVLVCAcctNo = '',
    drvVLVCEffDate = '',
    drvVLVCPlanCode = '',
    drvVLVCClassCode = '',
    drvVLVCCTier = '',
    drvVLVCOtherIns = '',
    drvVLVCEmpWaiver = '',
    drvVLVCDepWaiver = '',
    drvVLVCOtherInsType = '',
--END_NEW
    drvVDNGrpAcctNo = den.acct,
    drvVDNEffDate = CONVERT(varchar(10), den.startd, 101),
    drvVDNPlanCode = den.planc,
    drvVDNClassCode = den.class,
    drvVDNCvg = den.cvg,
    drvVDNCovTier = case when den.tier in ('EE') then '1'
                          when den.tier in ('ES') then '2'
                          when den.tier in ('EC') then '3'
                          when den.tier in ('EF') then '4'
                    else '' end,
    drvVDNOtherIns = '',
    drvVDNNameIns1 = '',
    drvVDNInsCo1 = '',
    drvVDNEmployer1 = '',
    drvVDNInsPlan1 = '',
    drvVDNNameIns2 = '',
    drvVDNInsCo2 = '',
    drvVDNEmployer2 = '',
    drvVDNInsPlan2 = '',
    drvVDNEmpWaiver = '',
    drvDepWaiver = '',
    drvVDNOtherInsType = '',
    drvVDMOGrpAcctNo = '',
    drvVDMOEffDate = '',
    drvVDMOPlanCode = '',
    drvVDMOClassCode = '',
    drvVDMOCvg = '',
    drvVDMOCovTier = '',
    drvVDMOPCP = '',
--Vol Life
    drvVLIFGrpAcctNo = coalesce(vl.acct,sl.acct,cl.acct),--coalesce(vl.acct,sd.acct,vd.acct,sl.acct,cl.acct),
    drvVLIFEffDate =CONVERT(varchar(10), coalesce(vl.effdate,sl.effdate,cl.effdate),101),--CONVERT(varchar(10), coalesce(vl.effdate,sd.effdate,vd.effdate,sl.effdate,cl.effdate),101),
    drvVLIFPlanCode = coalesce(vl.planc,sl.planc,cl.planc),--coalesce(vl.planc,sd.planc,vd.planc,sl.planc,cl.planc),
    drvVLIFClassCode = coalesce(vl.class,sl.class,cl.class),--coalesce(vl.class,sd.class,vd.class,sl.class,cl.class),
--Please see my comments at the top of the stored procedure to understand why this complex case statement exists
    drvVLIFCvg = case   
                    when vc.vccount = 1 then substring(c1.cvg,1,len(c1.cvg)-1)
                    when vc.vccount = 2 then c1.cvg + isnull(substring(c2.cvg,1,len(c2.cvg)-1),'')
                    when vc.vccount = 3 then c1.cvg + c2.cvg + isnull(substring(c3.cvg,1,len(c3.cvg)-1),'')
                    when vc.vccount = 4 then c1.cvg + c2.cvg + c3.cvg + isnull(substring(c4.cvg,1,len(c4.cvg)-1),'')
                    when vc.vccount = 5 then c1.cvg + c2.cvg + c3.cvg + c4.cvg + isnull(substring(c5.cvg,1,len(c5.cvg)-1),'')
                    when vc.vccount = 6 then c1.cvg + c2.cvg + c3.cvg + c4.cvg + c5.cvg + isnull(substring(c6.cvg,1,len(c6.cvg)-1),'')
                    else '' end,    
    drvVLIFVADDOption = '',
--Vol Weekly Income
    drvVWIGrpAcctNo = '',    --vwi.acct,
    drvVWIEffDAte = '',    --CONVERT(varchar(10), vwi.effdate, 101),
    drvVWIPlanCode = '',    --vwi.planc,
    drvVWClassCode = '',    --vwi.class,
    drvVWCvg = '',    --vwi.cvg,
    drvVWIBenAmt = '',
    drvVWIElimPeriod = '',
    drvVWIBenfitPct = '',
--Vol LTD
    drvVLTDGrpAcctNo =  '',    --vltd.acct,
    drvVLTDEffDate = '',    --CONVERT(varchar(10), vltd.effdate, 101),
    drvVLTDPlanCode = '',    --vltd.planc,
    drvVLTDClassCode = '',    --vltd.class,
    drvVLTDCvg = '',    --vltd.cvg,
    drvVLTDBenDuration = '',
    drvVLTDBenAmt = '',
    drvVLTDElimPeriod = '',
    drvVLTDBenPct = '',
--other non-applicable fields
    drvSTADACCNo = coalesce(vd.acct,sd.acct,cd.acct),
    drvSTADEffDate = CONVERT(varchar(10), coalesce(vd.effdate,sd.effdate,cd.effdate),101),
    drvSTADPlanCode = coalesce(vd.planc,sd.planc,cd.planc),
    drvSTADClassCode = coalesce(vd.class,sd.class,cd.class),
    drvSTADCov = case when vad.vccount = 1 then substring(ad1.cvg,1,len(ad1.cvg)-1)
                    when vad.vccount = 2 then ad1.cvg + substring(ad2.cvg,1,len(ad2.cvg)-1)
                    when vad.vccount = 3 then ad1.cvg + ad2.cvg + substring(ad3.cvg,1,len(ad3.cvg)-1)
                    else '' end,
    drvReasonCode = '',
    drvReasonEffDate = '',
    drvEmpComments = '',
    drvASOInd = '',
    drvVLIFESmoker = '',--EepIsSmoker,        
    drvVLIFSpsSmoker = '',--sps.cSmoker,        
    drvVLIFSpsDOB = CASE WHEN EXISTS (Select *
                        from dbo.u_dsi_bdm_EmpDeductions
                        where EedFormatCode = @FormatCode 
                        AND EedValidForExport = 'Y'
                        AND Eeddedcode  = 'LIFES'
                        AND EedEEID = xEEID
                        AND EedCOID = xCOID) THEN convert(char(10),sps.cDoB,101) END,        
--dependents
    drvDepFName1 = '',--d1.fname,
    drvDepLName1 = '',--d1.lname,
    drvDepMName1 = '',--d1.MName,
    drvDepGender1 = '',--d1.conGender,
    drvDepDOB1 = '',--convert(char(10),d1.cDoB,101),
    drvDepRelationship = '',--d1.cRel,
    drvDepStudent1 = '',--d1.cstudent,
    drvDepCovInd1 = '',
    drvDepPCP1 = '',
    drvDepFName2 = '',--d2.fname,
    drvDepLName2 = '',--d2.lname,
    drvDepMName2 = '',--d2.MName,
    drvDepGender2 = '',--d2.conGender,
    drvDepDOB2 = '',--convert(char(10),d2.cDoB,101),
    drvDepRelationship2 = '',--d2.cRel,
    drvDepStudent2 = '',--d2.cstudent,
    drvDepCovInd2 = '',
    drvDepPCP2 = '',
    drvDepFName3 = '',--d3.fname,
    drvDepLName3 = '',--d3.lname,
    drvDepMName3 = '',--d3.MName,
    drvDepGender3 = '',--d3.conGender,
    drvDepDOB3 = '',--convert(char(10),d3.cDoB,101),
    drvDepRelationship3 = '',--d3.cRel,
    drvDepStudent3 = '',--d3.cstudent,
    drvDepCovInd3 = '',
    drvDepPCP3 = '',
    drvDepFName4 = '',--d4.fname,
    drvDepLName4 = '',--d4.lname,
    drvDepMName4 = '',--d4.MName,
    drvDepGender4 = '',--d4.conGender,
    drvDepDOB4 = '',--convert(char(10),d4.cDoB,101),
    drvDepRelationship4 = '',--d4.cRel,
    drvDepStudent4 = '',--d4.cstudent,
    drvDepCovInd4 = '',
    drvDepPCP4 = '',
    drvDepFName5 = '',--d5.fname,
    drvDepLName = '',--d5.lname,
    drvDepMName5 = '',--d5.MName,
    drvDepGender5 = '',--d5.conGender,
    drvDepDOB5 = '',--convert(char(10),d5.cDoB,101),
    drvDepRelationship5 = '',--d5.cRel,
    drvDepStudent5 = '',--d5.cstudent,
    drvDepCovInd5 = '',
    drvDepPCP5 = '',
    drvDepFName6 = '',--d6.fname,
    drvDepLName6 = '',--d6.lname,
    drvDepMName6 = '',--d6.MName,
    drvDepGender6 = '',--d6.conGender,
    drvDepDOB6 = '',--convert(char(10),d6.cDoB,101),
    drvDepRelationship6 = '',--d6.cRel,
    drvDepStudent6 = '',--d6.cstudent,
    drvDepCovInd6 = '',
    drvDepPCP6 = ''    

  into dbo.U_dsi_ELFGEDIT2C_drvTbl
  from dbo.u_ELFGEDIT2C_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join jobcode with (nolock) on eecJobCode = jbcJobCode
    left join (select ejheeid, ejhcoid, max(ejhjobeffdate) saleffdate
        from emphjob where ejhisratechange = 'Y' group by ejheeid,ejhcoid) jh on jh.ejheeid = xeeid and jh.ejhcoid = xcoid
--LI/AD
    left join (select distinct eedeeid eeid, eedcoid coid, 
    case 
    when rtrim(eecpaygroup) = 'CRP' then '1586963'
    when rtrim(eecpaygroup) = 'OLA' then '1587380'
    when rtrim(eecpaygroup) = 'GRV' then '1587381'
    when rtrim(eecpaygroup) = 'OWS' then '1587383'
    when rtrim(eecpaygroup) = 'CHA' then '1587384'
    when rtrim(eecpaygroup) = 'CHP' then '1587385'
    when rtrim(eecpaygroup) = 'STL' then '1595651'
    end acct, 
    --case when min(eedBenStartDate) < '01/01/2017' then '01/01/2017' else min(eedBenStartDate) end  date, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end date,
    '1' planc,
    case 
    when eecsalaryorhourly = 'S' then '1'    
    when eecsalaryorhourly = 'H' then '2'    
    end class, 
    case
    when dl.deeid is not null then '"DLI-1, LI-1, AD-1"' 
    when dl.deeid is null then '"LI-1, AD-1"' 
    end cvg
        from dbo.U_dsi_bdm_EmpDeductions 
        join empcomp on eedeeid = eeceeid and eedcoid = eeccoid
        left join (select distinct eedcoid dcoid,eedeeid deeid from dbo.U_dsi_bdm_EmpDeductions where eeddedcode IN ('GLIFD') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') dl 
        on dl.dcoid = eedcoid and dl.deeid = eedeeid
        where eeddedcode IN ('GLIFE','GLIFN')
        and eedFormatCode = @FormatCode and eedValidForExport = 'Y'
       --group by EedEEID, EedCoID
        
        --case 
        --    when eeddedcode = 'GLIFE' then '30000'
        --    when eeddedcode = 'GLIFX' then '75000'    
        --end 

        ) ladd on ladd.eeid = xeeid and ladd.coid = xcoid
--WI
    left join (select eedeeid eeid, eedcoid coid, 
    case 
    when rtrim(eecpaygroup)= 'CRP' then '1586963'
    when rtrim(eecpaygroup)= 'OLA' then '1587380'
    when rtrim(eecpaygroup)= 'GRV' then '1587381'
    when rtrim(eecpaygroup)= 'OWS' then '1587383'
    when rtrim(eecpaygroup)= 'CHA' then '1587384'
    when rtrim(eecpaygroup)= 'CHP' then '1587385'
    when rtrim(eecpaygroup)= 'STL' then '1595651'
    end acct, 
    --case when eedBenStartDate < '01/01/2017' then '01/01/2017' else eedBenStartDate end startd, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end startd,
    '1' planc,
    case 
    when eecsalaryorhourly = 'S' then '1'    
    when eecsalaryorhourly = 'H' then '2'    
    end class, 
    'WI-1' cvg, --Syed Salehin 05/04/17: per vendor call. Commented out the secion below.
    --case when (
    --case 
    --when eecsalaryorhourly = 'S' then eecannsalary/52 
    --when eecsalaryorhourly = 'H' then eechourlypayrate*40
    --end) > 1000 then '1000' else 
    --ROUND(convert(varchar,(
    --case 
    --when eecsalaryorhourly = 'S' then eecannsalary/52 
    --when eecsalaryorhourly = 'H' then eechourlypayrate*40
    --end)),2)
    --end cvg, 
    eeddedcode
        from dbo.U_dsi_bdm_EmpDeductions join EmpComp on EedEEID = EecEEID and EedCoID = EecCoID
        where eeddedcode IN ('STD') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') wi on wi.eeid = xeeid and wi.coid = xcoid
--LTD
    left join (select eedeeid eeid, eedcoid coid, 
    case 
    when rtrim(eecpaygroup)= 'CRP' then '1586963'
    when rtrim(eecpaygroup)= 'OLA' then '1587380'
    when rtrim(eecpaygroup)= 'GRV' then '1587381'
    when rtrim(eecpaygroup)= 'OWS' then '1587383'
    when rtrim(eecpaygroup)= 'CHA' then '1587384'
    when rtrim(eecpaygroup)= 'CHP' then '1587385'
    when rtrim(eecpaygroup)= 'STL' then '1595651'
    end acct, 
    --case when eedBenStartDate < '01/01/2017' then '01/01/2017' else eedBenStartDate end date, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end date, 
    '1' planc,
    case 
    when eecsalaryorhourly = 'S' then '1'    
    when eecsalaryorhourly = 'H' then '2'    
    end class, 
    case 
    when oltd.deeid is not null then '"LTD-1, OLTD-1"' 
    when oltd.deeid is null then '"LTD-1"' 
    end cvg, 
    --convert(varchar,ROUND(case 
    --when eeddedcode = 'LTDH' then case when ((eechourlypayrate*40*52/12)*0.60) > 5000 then '5000' else ((eechourlypayrate*40*52/12)*0.60) end
    --when eeddedcode = 'LTDS' then case when ((eecannsalary/12)*0.60) > 10000 then '10000' else ((eecannsalary/12)*0.60) end    
    --end,2)) cvg, 
    eeddedcode
        from dbo.U_dsi_bdm_EmpDeductions 
        join empcomp on eedeeid = eeceeid and eedcoid = eeccoid
        left join (select distinct eedcoid dcoid,eedeeid deeid from dbo.U_dsi_bdm_EmpDeductions where eeddedcode IN ('LTD') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') oltd 
        on oltd.dcoid = eedcoid and oltd.deeid = eedeeid
        where eeddedcode IN ('LTDE') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') ltd on ltd.eeid = xeeid and ltd.coid = xcoid
--DEN
    left join (select eedeeid eeid, eedcoid coid, '1569479' acct, 
    eedBenStartDate startd, 
    '1' planc, '1' class, 'VDN' cvg, eedbenoption tier
        from dbo.U_dsi_bdm_EmpDeductions where eeddedcode IN ('XXXXX') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') den on den.eeid = xeeid and den.coid = xcoid
--DHMO
    left join (select eedeeid eeid, eedcoid coid, '1541445' acct, eedBenStartDate startd, '1' planc, '1' class, 'DHMO' cvg, eedbenoption tier
        from dbo.U_dsi_bdm_EmpDeductions where eeddedcode IN ('XXXXX') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') dhmo on dhmo.eeid = xeeid and dhmo.coid = xcoid
--VC
    left join (select ceeid eeid, ccoid coid,count(csort) as vccount from dbo.U_dsi_ELFGEDIT2C_volcovTbl
                group by ceeid,ccoid) VC on VC.eeid = xeeid and VC.coid = xcoid
--VC
    left join (select ceeid eeid, ccoid coid,count(csort) as vccount from dbo.U_dsi_ELFGEDIT2C_volADDcovTbl
                group by ceeid,ccoid) VAD on VAD.eeid = xeeid and VAD.coid = xcoid
--C1-C5 for VLIF Coverages
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDIT2C_volcovTbl) C1 on C1.eeid = xeeid and C1.coid = xcoid and C1.Cno = '1'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDIT2C_volcovTbl) C2 on C2.eeid = xeeid and C2.coid = xcoid and C2.Cno = '2'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDIT2C_volcovTbl) C3 on C3.eeid = xeeid and C3.coid = xcoid and C3.Cno = '3'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDIT2C_volcovTbl) C4 on C4.eeid = xeeid and C4.coid = xcoid and C4.Cno = '4'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDIT2C_volcovTbl) C5 on C5.eeid = xeeid and C5.coid = xcoid and C5.Cno = '5'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDIT2C_volcovTbl) C6 on C6.eeid = xeeid and C6.coid = xcoid and C6.Cno = '6'
--AD1-AD3 for VAD Coverages
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDIT2C_volADDcovTbl) AD1 on AD1.eeid = xeeid and AD1.coid = xcoid and AD1.Cno = '1'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDIT2C_volADDcovTbl) AD2 on AD2.eeid = xeeid and AD2.coid = xcoid and AD2.Cno = '2'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDIT2C_volADDcovTbl) AD3 on AD3.eeid = xeeid and AD3.coid = xcoid and AD3.Cno = '3'
--VL
    left join (select eedeeid eeid, eedcoid coid, 
    case 
    when rtrim(eecpaygroup)= 'CRP' then '1586963'
    when rtrim(eecpaygroup)= 'OLA' then '1587380'
    when rtrim(eecpaygroup)= 'GRV' then '1587381'
    when rtrim(eecpaygroup)= 'OWS' then '1587383'
    when rtrim(eecpaygroup)= 'CHA' then '1587384'
    when rtrim(eecpaygroup)= 'CHP' then '1587385'
    when rtrim(eecpaygroup)= 'STL' then '1595651'
    end acct, 
    --case when eedBenStartDate < '01/01/2017' then '01/01/2017' else eedBenStartDate end effdate, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end effdate,
    '1' planc,
    case 
    when eecsalaryorhourly = 'S' then '1'    
    when eecsalaryorhourly = 'H' then '2'    
    end class
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eedeeid = eeceeid and eedcoid = eeccoid
        where eeddedcode IN ('LIFEE') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') VL on VL.eeid = xeeid and VL.coid = xcoid
--VD
    left join (select eedeeid eeid, eedcoid coid,
    case 
    when rtrim(eecpaygroup)= 'CRP' then '1587387'
    when rtrim(eecpaygroup)= 'OLA' then '1587388'
    when rtrim(eecpaygroup)= 'GRV' then '1587389'
    when rtrim(eecpaygroup)= 'OWS' then '1587390'
    when rtrim(eecpaygroup)= 'CHA' then '1587392'
    when rtrim(eecpaygroup)= 'CHP' then '1587393'
    when rtrim(eecpaygroup)= 'STL' then '1595652'
    end acct, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end effdate, 
    '1' planc,
    case 
    when eecsalaryorhourly = 'S' then '1'    
    when eecsalaryorhourly = 'H' then '2'    
    end class
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eeceeid = eedeeid and eeccoid = eedcoid
        where eeddedcode IN ('VADDE') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') VD on VD.eeid = xeeid and VD.coid = xcoid
--SL
    left join (select eedeeid eeid, eedcoid coid,
    case 
    when rtrim(eecpaygroup)= 'CRP' then '1586963'
    when rtrim(eecpaygroup)= 'OLA' then '1587380'
    when rtrim(eecpaygroup)= 'GRV' then '1587381'
    when rtrim(eecpaygroup)= 'OWS' then '1587383'
    when rtrim(eecpaygroup)= 'CHA' then '1587384'
    when rtrim(eecpaygroup)= 'CHP' then '1587385'
    when rtrim(eecpaygroup)= 'STL' then '1595651'
    end acct, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end effdate, 
    '1' planc,
    case 
    when eecsalaryorhourly = 'S' then '1'    
    when eecsalaryorhourly = 'H' then '2'    
    end class
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eeceeid = eedeeid and eeccoid = eedcoid
        where eeddedcode IN ('LIFES') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') SL on SL.eeid = xeeid and SL.coid = xcoid
--SD
    left join (select eedeeid eeid, eedcoid coid, 
    case 
    when rtrim(eecpaygroup)= 'CRP' then '1587387'
    when rtrim(eecpaygroup)= 'OLA' then '1587388'
    when rtrim(eecpaygroup)= 'GRV' then '1587389'
    when rtrim(eecpaygroup)= 'OWS' then '1587390'
    when rtrim(eecpaygroup)= 'CHA' then '1587392'
    when rtrim(eecpaygroup)= 'CHP' then '1587393'
    when rtrim(eecpaygroup)= 'STL' then '1595652'
    end acct, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end effdate, 
    '1' planc,
    case 
    when eecsalaryorhourly = 'S' then '1'    
    when eecsalaryorhourly = 'H' then '2'    
    end class
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eedeeid = eeceeid and eedcoid = eeccoid
        where eeddedcode IN ('VADDS') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') SD on SD.eeid = xeeid and SD.coid = xcoid
--CL
    left join (select eedeeid eeid, eedcoid coid, 
    case 
    when rtrim(eecpaygroup)= 'CRP' then '1586963'
    when rtrim(eecpaygroup)= 'OLA' then '1587380'
    when rtrim(eecpaygroup)= 'GRV' then '1587381'
    when rtrim(eecpaygroup)= 'OWS' then '1587383'
    when rtrim(eecpaygroup)= 'CHA' then '1587384'
    when rtrim(eecpaygroup)= 'CHP' then '1587385'
    when rtrim(eecpaygroup)= 'STL' then '1595651'
    end acct, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end effdate, 
    '1' planc, 
    case 
    when eecsalaryorhourly = 'S' then '1'    
    when eecsalaryorhourly = 'H' then '2'    
    end class
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eeceeid = eedeeid and eeccoid = eedcoid
        where eeddedcode IN ('LIFEC') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') CL on CL.eeid = xeeid and CL.coid = xcoid
--CD
    left join (select eedeeid eeid, eedcoid coid, 
    case 
    when rtrim(eecpaygroup)= 'CRP' then '1587387'
    when rtrim(eecpaygroup)= 'OLA' then '1587388'
    when rtrim(eecpaygroup)= 'GRV' then '1587389'
    when rtrim(eecpaygroup)= 'OWS' then '1587390'
    when rtrim(eecpaygroup)= 'CHA' then '1587392'
    when rtrim(eecpaygroup)= 'CHP' then '1587393'
    when rtrim(eecpaygroup)= 'STL' then '1595652'
    end acct, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end effdate, 
    '1' planc,
    case 
    when eecsalaryorhourly = 'S' then '1'    
    when eecsalaryorhourly = 'H' then '2'    
    end class
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eeceeid = eedeeid and eeccoid = eedcoid
        where eeddedcode IN ('VADDC') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') CD on CD.eeid = xeeid and CD.coid = xcoid

--ACC
    left join (select eedeeid eeid, eedcoid coid, '1541445' acct, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end effdate, 
    'Choice Plan' planc,
        '000404003299' policy, '1540048' bloc,
        '1' class,
        case when EedBenOption = 'EE' then 'Employee Only'
            when EedBenOption in ('EES','EDP') then 'Employee + Spouse'
            when EedBenOption in ('EEC','EC1') then 'Employee + Child(ren)'
            when EedBenOption in ('EEF','EDPF') then 'Employee + Family'
        else '' end tier
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eeceeid = eedeeid and eeccoid = eedcoid
        where eeddedcode IN ('XXXXX') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') acc on acc.eeid = xeeid and acc.coid = xcoid

--CI
    left join (select eedeeid eeid, eedcoid coid, '1541445' acct, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end effdate, 
    '1' planc,
        '000405004060' policy, '1540048' bloc,
        case when eedBenAmt >= 35000 then '2'
        else '1' end class, eedBenAmt Amt, eedBenAmt*.25 ChAmt
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eeceeid = eedeeid and eeccoid = eedcoid
        where eeddedcode IN ('XXXXX') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') CI on CI.eeid = xeeid and CI.coid = xcoid
--SPCI
    left join (select eedeeid eeid, eedcoid coid, '1541445' acct, 
    case when eedBenStartDate < @plandate then @plandate else eedBenStartDate end effdate, 
    '1' planc,
        '000405004060' policy, '1540048' bloc,
        case when eeceetype in ('GDF') then '2'
        else '1' end class, eedBenAmt Amt, eedBenAmt*.25 ChAmt
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eeceeid = eedeeid and eeccoid = eedcoid
        where eeddedcode IN ('XXXXX') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') SPCI on SPCI.eeid = xeeid and SPCI.coid = xcoid

    left join (select * from dbo.U_dsi_ELFGEDIT2C_depTbl where cRel in ('S')) sps on sps.drveeid = xeeid and sps.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDIT2C_depTbl where drvrank = '01') d1 on d1.drveeid = xeeid and d1.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDIT2C_depTbl where drvrank = '02') d2 on d2.drveeid = xeeid and d2.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDIT2C_depTbl where drvrank = '03') d3 on d3.drveeid = xeeid and d3.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDIT2C_depTbl where drvrank = '04') d4 on d4.drveeid = xeeid and d4.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDIT2C_depTbl where drvrank = '05') d5 on d5.drveeid = xeeid and d5.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDIT2C_depTbl where drvrank = '06') d6 on d6.drveeid = xeeid and d6.drvcoid = xcoid

where exists (select 1 from dbo.U_dsi_bdm_EmpDeductions where eedeeid = xeeid and eedcoid = xcoid
                and eedFormatCode = @FormatCode and eedValidForExport = 'Y');

--Syed Salehin 10/25/16: Remove additional comma at the end of the drvvlifcvg column
update U_dsi_ELFGEDIT2C_drvTbl set drvvlifcvg = substring(drvvlifcvg,1,len(drvvlifcvg)-1)
from dbo.U_dsi_ELFGEDIT2C_drvTbl where right(ltrim(rtrim(drvvlifcvg)),1) = ','

--select * from dbo.U_dsi_ELFGEDIT2C_volcovTbl order by ccov
--select * from dbo.U_ELFGEDIT2C_DedData

----select drvVLIFCvg,* from dbo.U_dsi_ELFGEDIT2C_drvTbl

--remove trailing comma
--update dbo.U_dsi_ELFGEDIT2C_drvTbl
--    set drvVLIFCvg = substring(drvVLIFCvg,1,len(drvVLIFCvg) - 1)
--    where len(drvVLIFCvg) > 0

-- Set FileName
if (dbo.dsi_fnVariable('ELFGEDIT2C','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'TECHI_LFG_' + convert(char(8),getdate(),112) + '.csv'
    where FormatCode = 'ELFGEDIT2C';

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwELFGEDIT2C_Export as
        select top 2000000 rtrim(Data) as Data
        from dbo.U_ELFGEDIT2C_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)

select expformatcode, expexportcode, expstartpercontrol, expendpercontrol, *
from ascexp where expformatcode = 'ELFGEDIT2C'    
*/

--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDIT2C','ELFGEDIT2C'
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDIT2C','ACTIVEOE'
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDIT2C','PASSIVEOE'
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDIT2C','TEST'
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDIT2C','ZAP'

END
GO
Create View dbo.dsi_vwELFGEDIT2C_Export as
        select top 2000000 rtrim(Data) as Data
        from dbo.U_ELFGEDIT2C_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)