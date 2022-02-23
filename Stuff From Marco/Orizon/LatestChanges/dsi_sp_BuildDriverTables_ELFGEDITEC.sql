SET NOCOUNT ON;
IF OBJECT_ID('U_ELFGEDITEC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELFGEDITEC_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELFGEDITEC_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELFGEDITEC' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELFGEDITEC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELFGEDITEC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELFGEDITEC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELFGEDITEC];
GO
IF OBJECT_ID('U_ELFGEDITEC_File') IS NOT NULL DROP TABLE [dbo].[U_ELFGEDITEC_File];
GO
IF OBJECT_ID('U_ELFGEDITEC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELFGEDITEC_EEList];
GO
IF OBJECT_ID('U_dsi_ELFGEDITEC_volcovTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELFGEDITEC_volcovTbl];
GO
IF OBJECT_ID('U_dsi_ELFGEDITEC_volADDcovTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELFGEDITEC_volADDcovTbl];
GO
IF OBJECT_ID('U_dsi_ELFGEDITEC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELFGEDITEC_drvTbl];
GO
IF OBJECT_ID('U_dsi_ELFGEDITEC_depTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELFGEDITEC_depTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELFGEDITEC';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELFGEDITEC';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELFGEDITEC';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELFGEDITEC';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELFGEDITEC';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ELFGEDITEC','Lincoln EDI file','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','6000','S','N','AZJTDT0000K0','N','Jan 20 2016 12:01PM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('ACTION TYPE','1','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CHANGE DATE','2','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('DEP CHANGE DATE','3','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','23',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('TERMINATION DATE','4','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr First Name','5','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','47',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr Last Name','6','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','62',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr Middle Initial','7','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','76',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr SSN','8','(''DA''=''T,'')','AZJTDT0000K0','8','H','1','94',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr Gender','9','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','102',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr DOB','10','(''DA''=''T,'')','AZJTDT0000K0','8','H','1','113',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('App Sign Date','11','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','121',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Occupation','12','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Hrs per Week','13','(''DA''=''T,'')','AZJTDT0000K0','12','H','1','144',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Salary Amt','14','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','156',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Salary Code','15','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','166',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Sal Eff Date','16','(''DA''=''T,'')','AZJTDT0000K0','12','H','1','177',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr Addr 1','17','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','189',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr Addr 2','18','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','200',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr City','19','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','211',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr State','20','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','220',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr Zip Code','21','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','230',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr Zip Plus 4','22','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','243',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Home Phone','23','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','258',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Work Phone','24','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','268',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Work Phone Ext','25','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','278',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Date of Hire','26','(''DA''=''T,'')','AZJTDT0000K0','12','H','1','292',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Spouse First Name','27','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','304',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Spouse Last Name','28','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','321',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Spouse Middle Init','29','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','337',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Spouse SSN','30','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','355',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Spouse Gender','31','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','365',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Spouse DOB','32','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','378',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Spouse SOB','33','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','388',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Emp SOB','34','(''DA''=''T,'')','AZJTDT0000K0','7','H','1','398',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Marital Status','35','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','405',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Rehire Date','36','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','419',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Email Address','37','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','430',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Union Flag','38','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','443',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Exempt Flag','39','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','453',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Health Plan Date','40','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','464',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene First Name','41','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','480',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene Last Name','42','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','501',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene Middle Init','43','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','521',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene Relationship','44','(''DA''=''T,'')','AZJTDT0000K0','23','H','1','541',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene Address 1','45','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','564',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene Address 2','46','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','584',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene City','47','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','604',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene State','48','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','619',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene Zip Code','49','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','635',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene Zip Plus 4','50','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','654',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Pri Bene SSN','51','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','675',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene First Name','52','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','689',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene Last Name','53','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','709',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene Middle Init','54','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','728',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene Relationship','55','(''DA''=''T,'')','AZJTDT0000K0','22','H','1','747',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene Address 1','56','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','769',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene Address 2','57','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','788',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene City','58','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','807',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene State','59','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','821',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene Zip Code','60','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','836',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene Zip Plus 4','61','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','854',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Co Bene SSN','62','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','874',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Beneficiary Comments','63','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','887',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident Policy Number','64','(''DA''=''T,'')','AZJTDT0000K0','22','H','1','907',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident BLOC Account Num','65','(''DA''=''T,'')','AZJTDT0000K0','25','H','1','929',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident Sort Group','66','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','954',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident Eff Date','67','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','973',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident Plan Code','68','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','990',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident Class Code','69','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','1008',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident Tier Code','70','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','1027',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Health Asses Tier','71','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','1045',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Hospital Tier','72','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','1062',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident Disability Amount','73','(''DA''=''T,'')','AZJTDT0000K0','26','H','1','1075',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident DI Tier','74','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','1101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident DI Benefit Period','75','(''DA''=''T,'')','AZJTDT0000K0','26','H','1','1117',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident DI Elim Period','76','(''DA''=''T,'')','AZJTDT0000K0','23','H','1','1143',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident Sickness Disability Amount','77','(''DA''=''T,'')','AZJTDT0000K0','35','H','1','1166',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident/sick Tier','78','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','1201',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident/sick DI','79','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','1219',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Accident/sick DI Elim Period','80','(''DA''=''T,'')','AZJTDT0000K0','28','H','1','1235',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CI Policy Number','81','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','1263',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CI BLOC Account Num/Sort Group','82','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','1279',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CI Eff Date','83','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','1309',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CI Plan Code','84','(''DA''=''T,'')','AZJTDT0000K0','12','H','1','1320',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CI Class Code','85','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','1332',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Principal Sum Amt Approved','86','(''DA''=''T,'')','AZJTDT0000K0','29','H','1','1345',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Principal Sum Amt Pending','87','(''DA''=''T,'')','AZJTDT0000K0','28','H','1','1374',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Principal Sum Amt Approved','88','(''DA''=''T,'')','AZJTDT0000K0','29','H','1','1402',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Principal Sum Amt Pending','89','(''DA''=''T,'')','AZJTDT0000K0','28','H','1','1431',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Principal Sum Amt Approved','90','(''DA''=''T,'')','AZJTDT0000K0','29','H','1','1459',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Principal Sum Amt Pending','91','(''DA''=''T,'')','AZJTDT0000K0','28','H','1','1488',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Heart Amt Approved','92','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','1516',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Heart Amt Pending','93','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','1537',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Heart Amt Approved','94','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','1557',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Heart Amt Pending','95','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','1578',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Heart Amt Approved','96','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','1598',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Heart Amt Pending','97','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','1619',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Cancer Amt Approved','98','(''DA''=''T,'')','AZJTDT0000K0','22','H','1','1639',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Cancer Amt Pending','99','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','1661',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Cancer Amt Approved','100','(''DA''=''T,'')','AZJTDT0000K0','22','H','1','1682',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Cancer Amt Pending','101','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','1704',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Cancer Amt Approved','102','(''DA''=''T,'')','AZJTDT0000K0','22','H','1','1725',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Cancer Amt Pending','103','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','1747',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Organ Amt Approved','104','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','1768',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Organ Amt Pending','105','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','1789',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Organ Amt Approved','106','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','1809',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Organ Amt Pending','107','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','1830',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Organ Amt Approved','108','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','1850',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Organ Amt Pending','109','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','1871',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Quality of Life Amt Approved','110','(''DA''=''T,'')','AZJTDT0000K0','31','H','1','1891',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Quality of Life Amt Pending','111','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','1922',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Quality of Life Amt Approved','112','(''DA''=''T,'')','AZJTDT0000K0','31','H','1','1952',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Quality of Life Amt Pending','113','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','1983',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Quality of Life Amt Approved','114','(''DA''=''T,'')','AZJTDT0000K0','31','H','1','2013',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Quality of Life Amt Pending','115','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','2044',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Child Category Amt Approved','116','(''DA''=''T,'')','AZJTDT0000K0','27','H','1','2074',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Child Category Amt Pending','117','(''DA''=''T,'')','AZJTDT0000K0','26','H','1','2101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Treatment Care Y/N','118','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','2127',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Treatment Care Y/N','119','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','2148',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Treatment Care Y/N','120','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','2169',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE DI Y/N','121','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','2190',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP DI Y/N','122','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','2199',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Accident Y/N','123','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','2208',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('SP Accident Y/N','124','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','2223',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('CH Accident Y/N','125','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','2238',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('EE Occ/HIV Y/N','126','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2253',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Life Bill. Location A/C Number','127','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','2267',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Life Eff Date','128','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','2297',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Life Plan Code','129','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2310',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Life Class Code','130','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','2324',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Life Cvgs','131','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','2339',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('WI Bill. Location A/C Number','132','(''DA''=''T,'')','AZJTDT0000K0','28','H','1','2348',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('WI Eff Date','133','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','2376',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('WI Plan Code','134','(''DA''=''T,'')','AZJTDT0000K0','12','H','1','2387',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('WI Class Code','135','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','2399',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('WI Cvgs','136','(''DA''=''T,'')','AZJTDT0000K0','7','H','1','2412',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LTD Bill. Location A/C Number','137','(''DA''=''T,'')','AZJTDT0000K0','29','H','1','2419',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LTD Eff Date','138','(''DA''=''T,'')','AZJTDT0000K0','12','H','1','2448',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LTD Plan Code','139','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','2460',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LTD Class Code','140','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2473',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LTD Cvgs','141','(''DA''=''T,'')','AZJTDT0000K0','8','H','1','2487',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dent Bill. Location A/C Number','143','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','2495',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dent Eff Date','144','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','2525',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dent Plan Code','145','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2538',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dent Class Code','146','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','2552',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dent Cvgs','147','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','2567',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dent Coverage Tier','148','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','2576',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dent Other Ins','149','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2594',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('DHMO Bill. Location A/C Number','151','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','2608',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('DHMO Eff Date','152','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','2638',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('DHMO Plan Code','153','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2651',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('DHMO Class Code','154','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','2665',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('DHMO Cvgs','155','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','2680',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('DHMO Coverage Tier','156','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','2689',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('DHMO PCP','157','(''DA''=''T,'')','AZJTDT0000K0','8','H','1','2707',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LVC Bill. Location A/C Number','158','(''DA''=''T,'')','AZJTDT0000K0','29','H','1','2715',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LVC Eff Date','159','(''DA''=''T,'')','AZJTDT0000K0','12','H','1','2744',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LVC Plan Code','160','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','2756',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LVC Class Code','161','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2769',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LVC Coverage Tier','162','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','2783',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LVC Other Ins','163','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','2800',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LVC Emp Waiver','164','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2813',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LVC Dep Waiver','165','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2827',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('LVC Other Ins Type','166','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','2841',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLVC Bill. Location A/C Number','167','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','2859',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLVC Eff Date','168','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','2889',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLVC Plan Code','169','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2902',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLVC Class Code','170','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','2916',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLVC Coverage Tier','171','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','2931',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLVC Other Ins','172','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','2949',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLVC Emp Waiver','173','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','2963',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLVC Dep Waiver','174','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','2978',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLVC Other Ins Type','175','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','2993',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDN Bill. Location A/C Number','176','(''DA''=''T,'')','AZJTDT0000K0','29','H','1','3012',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDN Eff Date','177','(''DA''=''T,'')','AZJTDT0000K0','12','H','1','3041',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDN Plan Code','178','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3053',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDN Class Code','179','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','3066',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDN Cvgs','180','(''DA''=''T,'')','AZJTDT0000K0','8','H','1','3080',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDN Coverage Tier','181','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','3088',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDN Other Ins','182','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3105',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDMO Bill. Location A/C Number','183','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','3118',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDMO Eff Date','184','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3148',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDMO Plan Code','185','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','3161',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDMO Class Code','186','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3175',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDMO Cvgs','187','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','3190',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDMO Coverage Tier','188','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','3199',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VDMO PCP','189','(''DA''=''T,'')','AZJTDT0000K0','8','H','1','3217',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLIF Bill. Location A/C Number','190','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','3225',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLIF Eff Date','191','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3255',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLIF Plan Code','192','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','3268',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLIF Class Code','193','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3282',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLIF Cvgs','194','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','3297',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLIF VADD Option','195','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','3306',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VWI Bill. Location A/C Number','196','(''DA''=''T,'')','AZJTDT0000K0','29','H','1','3322',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VWI Eff Date','197','(''DA''=''T,'')','AZJTDT0000K0','12','H','1','3351',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VWI Plan Code','198','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3363',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VWI Class Code','199','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','3376',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VWI Cvgs','200','(''DA''=''T,'')','AZJTDT0000K0','8','H','1','3390',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VWI Benefit Amt','201','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3398',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VWI Elim Period','202','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3413',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VWI Benefit Pct','203','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3428',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLTD Bill. Location A/C Number','204','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','3443',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLTD Eff Date','205','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3473',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLTD Plan Code','206','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','3486',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLTD Class Code','207','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3500',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLTD Cvgs','208','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','3515',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLTD Benefit Duration','209','(''DA''=''T,'')','AZJTDT0000K0','21','H','1','3524',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLTD Benefit Amt','210','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','3545',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLTD Elim Period','211','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','3561',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLTD Benefit Pct','212','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','3577',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('STAD Bill. Location A/C Number','213','(''DA''=''T,'')','AZJTDT0000K0','30','H','1','3593',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('STAD Eff Date','214','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3623',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('STAD Plan Code','215','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','3636',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('STAD Class Code','216','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3650',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('STAD Cvgs','217','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','3665',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Reason Code','218','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','3674',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Reason Eff Date','219','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3685',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Mbr Comments','220','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3700',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('ASO Indicator Y/N','221','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','3713',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLIF Emp Smoker','222','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3730',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLIF Spouse Smoker','223','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','3745',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('VLIF Spouse DOB','224','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3763',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep First Name','225','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','3778',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep Last Name','226','(''DA''=''T,'')','AZJTDT0000K0','14','H','1','3793',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep M I','227','(''DA''=''T,'')','AZJTDT0000K0','7','H','1','3807',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep Gender','228','(''DA''=''T,'')','AZJTDT0000K0','11','H','1','3814',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep DOB','229','(''DA''=''T,'')','AZJTDT0000K0','8','H','1','3825',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep Relationship Code','230','(''DA''=''T,'')','AZJTDT0000K0','22','H','1','3833',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep Student Code','231','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','3855',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep Cvg Indicator','233','(''DA''=''T,'')','AZJTDT0000K0','18','H','1','3872',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep DHMO PCP','234','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3890',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 2 First Name','235','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','3903',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 2 Last Name','236','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','3920',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 2 M I','237','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','3936',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 2 Gender','238','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','3945',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 2 DOB','239','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','3958',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 2 Relationship Code','240','(''DA''=''T,'')','AZJTDT0000K0','24','H','1','3968',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 2 Student Code','241','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','3992',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 2 Cvg Indicator','243','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','4011',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 2 DHMO PCP','244','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','4031',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 3 First Name','245','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','4046',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 3 Last Name','246','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','4063',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 3 M I','247','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','4079',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 3 Gender','248','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','4088',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 3 DOB','249','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','4101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 3 Relationship Code','250','(''DA''=''T,'')','AZJTDT0000K0','24','H','1','4111',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 3 Student Code','251','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','4135',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 3 Cvg Indicator','253','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','4154',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 3 DHMO PCP','254','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','4174',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 4 First Name','255','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','4189',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 4 Last Name','256','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','4206',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 4 M I','257','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','4222',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 4 Gender','258','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','4231',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 4 DOB','259','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','4244',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 4 Relationship Code','260','(''DA''=''T,'')','AZJTDT0000K0','24','H','1','4254',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 4 Student Code','261','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','4278',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 4 Cvg Indicator','263','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','4297',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 4 DHMO PCP','264','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','4317',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 5 First Name','265','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','4332',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 5 Last Name','266','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','4349',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 5 M I','267','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','4365',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 5 Gender','268','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','4374',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 5 DOB','269','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','4387',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 5 Relationship Code','270','(''DA''=''T,'')','AZJTDT0000K0','24','H','1','4397',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 5 Student Code','271','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','4421',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 5 Cvg Indicator','273','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','4440',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 5 DHMO PCP','274','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','4460',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 6 First Name','275','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','4475',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 6 Last Name','276','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','4492',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 6 M I','277','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','4508',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 6 Gender','278','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','4517',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 6 DOB','279','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','4530',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 6 Relationship Code','280','(''DA''=''T,'')','AZJTDT0000K0','24','H','1','4540',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 6 Student Code','281','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','4564',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 6 Cvg Indicator','283','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','4583',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 6 DHMO PCP','284','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','4603',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 7 First Name','285','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','4475',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 7 Last Name','286','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','4492',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 7 M I','287','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','4508',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 7 Gender','288','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','4517',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 7 DOB','289','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','4530',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 7 Relationship Code','290','(''DA''=''T,'')','AZJTDT0000K0','24','H','1','4540',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 7 Student Code','291','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','4564',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 7 Cvg Indicator','292','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','4583',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 7 DHMO PCP','293','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','4603',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 8 First Name','294','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','4475',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 8 Last Name','295','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','4492',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 8 M I','296','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','4508',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 8 Gender','297','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','4517',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 8 DOB','298','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','4530',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 8 Relationship Code','299','(''DA''=''T,'')','AZJTDT0000K0','24','H','1','4540',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 8 Student Code','300','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','4564',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 8 Cvg Indicator','301','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','4583',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 8 DHMO PCP','302','(''DA''=''T,'')','AZJTDT0000K0','15','H','1','4603',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 9 First Name','303','(''DA''=''T,'')','AZJTDT0000K0','17','H','1','4475',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 9 Last Name','304','(''DA''=''T,'')','AZJTDT0000K0','16','H','1','4492',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 9 M I','305','(''DA''=''T,'')','AZJTDT0000K0','9','H','1','4508',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 9 Gender','306','(''DA''=''T,'')','AZJTDT0000K0','13','H','1','4517',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 9 DOB','307','(''DA''=''T,'')','AZJTDT0000K0','10','H','1','4530',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 9 Relationship Code','308','(''DA''=''T,'')','AZJTDT0000K0','24','H','1','4540',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 9 Student Code','309','(''DA''=''T,'')','AZJTDT0000K0','19','H','1','4564',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 9 Cvg Indicator','310','(''DA''=''T,'')','AZJTDT0000K0','20','H','1','4583',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('Dep 9 DHMO PCP','311','(''DA''=''T'')','AZJTDT0000K0','15','H','1','4603',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvActionType','1','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','1',NULL,'ACTION TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvChangeDate','2','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','2',NULL,'CHANGE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepChangeDate','3','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','12',NULL,'DEP CHANGE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvTermDate','4','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','22',NULL,'TERM DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvNameFirst','5','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','32',NULL,'Mbr First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvNameLast','6','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','82',NULL,'Mbr Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvNameMI','7','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','132',NULL,'Mbr Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvESSN','8','(''UA''=''T,'')','AZJTDT0000K0','9','D','2','133',NULL,'Mbr SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvGender','9','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','142',NULL,'Mbr Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDOB','10','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','143',NULL,'Mbr DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAppSignDate','11','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','153',NULL,'App Sign Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvOccupation','12','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','163',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvHrsPerWeek','13','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','213',NULL,'Hrs per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSalary','14','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','219',NULL,'Salary Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSalaryCode','15','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','229',NULL,'Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSalEffDate','16','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','230',NULL,'Sal Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAddress1','17','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','240',NULL,'Mbr Addr 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAddress2','18','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','290',NULL,'Mbr Addr 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCity','19','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','340',NULL,'Mbr City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvState','20','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','390',NULL,'Mbr State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvZIP','21','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','392',NULL,'Mbr Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvZIPplus','22','(''UA''=''T,'')','AZJTDT0000K0','5','D','2','402',NULL,'Mbr Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPhoneHome','23','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','407',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPhoneBusiness','24','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','417',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvBusinessExt','25','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','427',NULL,'Work Phone Ext',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvHireDate','26','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','437',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSpsNameFirst','27','(''UA''=''T,'')','AZJTDT0000K0','35','D','2','442',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSpsNameLast','28','(''UA''=''T,'')','AZJTDT0000K0','35','D','2','477',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSpouseMI','29','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','512',NULL,'Spouse Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSpouseSSN','30','(''UA''=''T,'')','AZJTDT0000K0','11','D','2','513',NULL,'Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSpouseGender','31','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','524',NULL,'Spouse Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSpouseDOB','32','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','525',NULL,'Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSpouseStateOB','33','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','535',NULL,'Spouse SOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEmpStateOfBirth','34','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','537',NULL,'Emp SOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvMaritialStat','35','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','539',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvRehireDate','36','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','540',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEmail','37','(''UA''=''T,'')','AZJTDT0000K0','100','D','2','550',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvUnionFlag','38','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','650',NULL,'Union Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvExemptFlag','39','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','651',NULL,'Exempt Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvHlthPlanDate','40','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','652',NULL,'Health Plan Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenFName','41','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','662',NULL,'Pri Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenLName','42','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','712',NULL,'Pri Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenMName','43','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','762',NULL,'Pri Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenRelation','44','(''UA''=''T,'')','AZJTDT0000K0','9','D','2','812',NULL,'Pri Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenAdd1','45','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','821',NULL,'Pri Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenAdd2','46','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','871',NULL,'Pri Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenCity','47','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','921',NULL,'Pri Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenST','48','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','971',NULL,'Pri Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenZIP','49','(''UA''=''T,'')','AZJTDT0000K0','5','D','2','973',NULL,'Pri Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenZIPplus','50','(''UA''=''T,'')','AZJTDT0000K0','4','D','2','978',NULL,'Pri Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvPriBenSSN','51','(''UA''=''T,'')','AZJTDT0000K0','9','D','2','982',NULL,'Pri Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenFName','52','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','991',NULL,'Co Bene First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenLName','53','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','1041',NULL,'Co Bene Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenMName','54','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','1091',NULL,'Co Bene Middle Init',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenRelation','55','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','1141',NULL,'Co Bene Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenAdd1','56','(''UA''=''T,'')','AZJTDT0000K0','5','D','2','1143',NULL,'Co Bene Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenAdd2','57','(''UA''=''T,'')','AZJTDT0000K0','4','D','2','1148',NULL,'Co Bene Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenCity','58','(''UA''=''T,'')','AZJTDT0000K0','9','D','2','1152',NULL,'Co Bene City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenST','59','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','1161',NULL,'Co Bene State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenZIP','60','(''UA''=''T,'')','AZJTDT0000K0','5','D','2','1163',NULL,'Co Bene Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenZIPplus','61','(''UA''=''T,'')','AZJTDT0000K0','4','D','2','1168',NULL,'Co Bene Zip Plus 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCoBenSSN','62','(''UA''=''T,'')','AZJTDT0000K0','9','D','2','1172',NULL,'Co Bene SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvBenComments','63','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','1181',NULL,'Beneficiary Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccPolicyNo','64','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1231',NULL,'Accident Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccBLOCAcctNo','65','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1261',NULL,'Accident BLOC Account Num',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccSortGrp','66','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1291',NULL,'Accident Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccEffDate','67','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1321',NULL,'Accident Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccPlanCode','68','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1351',NULL,'Accident Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccClassCode','69','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1381',NULL,'Accident Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccTierCode','70','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1411',NULL,'Accident Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvHealthAssTier','71','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1441',NULL,'Health Asses Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvHospitalTier','72','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1471',NULL,'Hospital Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccDisabilityAmt','73','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1501',NULL,'Accident Disability Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccDITier','74','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1531',NULL,'Accident DI Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccDIBenPeriod','75','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1561',NULL,'Accident DI Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccDIElimPeriod','76','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1591',NULL,'Accident DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccSickDisAmt','77','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1621',NULL,'Accident Sickness Disability A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccSickTier','78','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1651',NULL,'Accident/sick Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccSickDIAmt','79','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1681',NULL,'Accident/sick DI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvAccSickDIElimPeriod','80','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1711',NULL,'Accident/sick DI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCIPolicyNo','81','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1741',NULL,'CI Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCIBLOCAccNoSortGrp','82','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1771',NULL,'CI BLOC Account Num/Sort Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCIEffDate','83','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1801',NULL,'CI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCIPlanCode','84','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1831',NULL,'CI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCIClassCode','85','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1861',NULL,'CI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEPrinAmtApproved','86','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','1891',NULL,'EE Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEPrinAmtPending','87','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','1921',NULL,'EE Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPPrinAmtApproved','88','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','1951',NULL,'SP Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPPrinAmtPending','89','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','1981',NULL,'SP Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHPrinAmtApproved','90','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2011',NULL,'CH Principal Sum Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHPrinAmtPending','91','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2041',NULL,'CH Principal Sum Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEHeartAmtApproved','92','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2071',NULL,'EE Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEHeartAmtPending','93','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2101',NULL,'EE Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPHeartAmtApproved','94','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2131',NULL,'SP Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPHeartAmtPending','95','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2161',NULL,'SP Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHHeartAmtApproved','96','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2191',NULL,'CH Heart Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHHeartAmtPending','97','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2221',NULL,'CH Heart Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEECanAmtApproved','98','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2251',NULL,'EE Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEECanAmtPending','99','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2281',NULL,'EE Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPCanAmtApproved','100','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2311',NULL,'SP Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPCanAmtPending','101','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2341',NULL,'SP Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHCanAmtApproved','102','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2371',NULL,'CH Cancer Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHCanAmtPending','103','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2401',NULL,'CH Cancer Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEOrganAmtApproved','104','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2431',NULL,'EE Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEOrganAmtPending','105','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2461',NULL,'EE Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPOrganAmtApproved','106','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2491',NULL,'SP Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPOrganAmtPending','107','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2521',NULL,'SP Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHOrganAmtApproved','108','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2551',NULL,'CH Organ Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHOrganAmtPending','109','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2581',NULL,'CH Organ Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEQualAmtApproved','110','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2611',NULL,'EE Quality of Life Amt Approve',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEQualAmtPending','111','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2641',NULL,'EE Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPQualAmtApproved','112','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2671',NULL,'SP Quality of Life Amt Approve',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPQualAmtPending','113','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2701',NULL,'SP Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHQualAmtApproved','114','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2731',NULL,'CH Quality of Life Amt Approve',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHQualAmtPending','115','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2761',NULL,'CH Quality of Life Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHCatAmtApproved','116','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2791',NULL,'Child Category Amt Approved',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHCatAmtPending','117','(''SS''=''T,'')','AZJTDT0000K0','30','D','2','2821',NULL,'Child Category Amt Pending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEETreatmentCare','118','(''SS''=''T,'')','AZJTDT0000K0','1','D','2','2851',NULL,'EE Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPTreatmentCare','119','(''SS''=''T,'')','AZJTDT0000K0','1','D','2','2852',NULL,'SP Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHTreatmentCare','120','(''SS''=''T,'')','AZJTDT0000K0','1','D','2','2853',NULL,'CH Treatment Care Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEDI','121','(''SS''=''T,'')','AZJTDT0000K0','1','D','2','2854',NULL,'EE DI Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPDI','122','(''SS''=''T,'')','AZJTDT0000K0','1','D','2','2855',NULL,'SP DI Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEAcc','123','(''SS''=''T,'')','AZJTDT0000K0','1','D','2','2856',NULL,'EE Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSPAcc','124','(''SS''=''T,'')','AZJTDT0000K0','1','D','2','2857',NULL,'SP Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvCHAcc','125','(''SS''=''T,'')','AZJTDT0000K0','1','D','2','2858',NULL,'CH Accident Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEEOccHIV','126','(''SS''=''T,'')','AZJTDT0000K0','1','D','2','2859',NULL,'EE Occ/HIV Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLifeGrpAcctNo','127','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','2860',NULL,'Life Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLifeEffDate','128','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','2890',NULL,'Life Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLifePlanCode','129','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','2900',NULL,'Life Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLifeClassCode','130','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','2906',NULL,'Life Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLiveCvg','131','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','2912',NULL,'Life Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvWIGrpAcctNo','132','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','2927',NULL,'WI Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvWIEffDate','133','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','2957',NULL,'WI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvWIPlanCode','134','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','2967',NULL,'WI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvWIClassCode','135','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','2973',NULL,'WI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvWICvg','136','(''UA''=''T,'')','AZJTDT0000K0','15','D','2','2979',NULL,'WI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLTDGrpAcctNo','137','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','2994',NULL,'LTD Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLTDEffDate','138','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','3024',NULL,'LTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLTDPlanCode','139','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','3034',NULL,'LTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLTDClassCode','140','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','3040',NULL,'LTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLTDCvg','141','(''UA''=''T,'')','AZJTDT0000K0','15','D','2','3046',NULL,'LTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDentGrpAcctNo','143','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3061',NULL,'Dent Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDentEffDate','144','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','3091',NULL,'Dent Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDentPlanCode','145','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','3101',NULL,'Dent Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDentClassCode','146','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','3107',NULL,'Dent Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDentCvg','147','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','3128',NULL,'Dent Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDentCvgTier','148','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','3128',NULL,'Dent Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDentOtherIns','149','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','3129',NULL,'Dent Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDHMOAcctNo','151','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3130',NULL,'DHMO Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDHMOEffDate','152','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','3160',NULL,'DHMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDHMOPlanCode','153','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','3170',NULL,'DHMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDHMOClassCode','154','(''UA''=''T,'')','AZJTDT0000K0','6','D','2','3176',NULL,'DHMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDHMOCvg','155','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3182',NULL,'DHMO Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDHMOTier','156','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3212',NULL,'DHMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDHMOPCP','157','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3242',NULL,'DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLVCAcctNo','158','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3272',NULL,'LVC Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLVCEffDate','159','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','3302',NULL,'LVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLVCPlanCode','160','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','3312',NULL,'LVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLVCClassCode','161','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','3314',NULL,'LVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLVCCTier','162','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3316',NULL,'LVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLVCOtherIns','163','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3346',NULL,'LVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLVCEmpWaiver','164','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3376',NULL,'LVC Emp Waiver',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLVCDepWaiver','165','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3406',NULL,'LVC Dep Waiver',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvLVCOtherInsType','166','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3436',NULL,'LVC Other Ins Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLVCAcctNo','167','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3466',NULL,'VLVC Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLVCEffDate','168','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','3496',NULL,'VLVC Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLVCPlanCode','169','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','3506',NULL,'VLVC Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLVCClassCode','170','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','3508',NULL,'VLVC Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLVCCTier','171','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3510',NULL,'VLVC Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLVCOtherIns','172','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3540',NULL,'VLVC Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLVCEmpWaiver','173','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3570',NULL,'VLVC Emp Waiver',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLVCDepWaiver','174','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3600',NULL,'VLVC Dep Waiver',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLVCOtherInsType','175','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3630',NULL,'VLVC Other Ins Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDNGrpAcctNo','176','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3660',NULL,'VDN Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDNEffDate','177','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','3690',NULL,'VDN Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDNPlanCode','178','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','3700',NULL,'VDN Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDNClassCode','179','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','3702',NULL,'VDN Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDNCvg','180','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3704',NULL,'VDN Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDNCovTier','181','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3734',NULL,'VDN Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDNOtherIns','182','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3764',NULL,'VDN Other Ins',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDMOGrpAcctNo','183','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3794',NULL,'VDMO Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDMOEffDate','184','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','3824',NULL,'VDMO Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDMOPlanCode','185','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3834',NULL,'VDMO Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDMOClassCode','186','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3864',NULL,'VDMO Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDMOCvg','187','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3894',NULL,'VDMO Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDMOCovTier','188','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3924',NULL,'VDMO Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVDMOPCP','189','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3954',NULL,'VDMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLIFGrpAcctNo','190','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','3984',NULL,'VLIF Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLIFEffDate','191','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4014',NULL,'VLIF Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLIFPlanCode','192','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','4024',NULL,'VLIF Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLIFClassCode','193','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','4026',NULL,'VLIF Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLIFCvg','194','(''UA''=''Q,'')','AZJTDT0000K0','100','D','2','4028',NULL,'VLIF Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLIFVADDOption','195','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4128',NULL,'VLIF VADD Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVWIGrpAcctNo','196','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4158',NULL,'VWI Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVWIEffDAte','197','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4188',NULL,'VWI Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVWIPlanCode','198','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','4198',NULL,'VWI Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVWClassCode','199','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','4200',NULL,'VWI Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVWCvg','200','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4202',NULL,'VWI Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVWIBenAmt','201','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4232',NULL,'VWI Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVWIElimPeriod','202','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4262',NULL,'VWI Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVWIBenfitPct','203','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4272',NULL,'VWI Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLTDGrpAcctNo','204','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4282',NULL,'VLTD Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLTDEffDAte','205','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4312',NULL,'VLTD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLTDPlanCode','206','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','4322',NULL,'VLTD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLTDClassCode','207','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','4324',NULL,'VLTD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLTDCvg','208','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4326',NULL,'VLTD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLTDBenDuration','209','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4356',NULL,'VLTD Benefit Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLTDBenAmt','210','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4386',NULL,'VLTD Benefit Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLTDElimPeriod','211','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4416',NULL,'VLTD Elim Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLTDBenPct','212','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4426',NULL,'VLTD Benefit Pct',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSTADACCNo','213','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4436',NULL,'STAD Bill. Location A/C Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSTADEffDate','214','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4466',NULL,'STAD Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSTADPlanCode','215','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','4476',NULL,'STAD Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSTADClassCode','216','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','4478',NULL,'STAD Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvSTADCov','217','(''UA''=''Q,'')','AZJTDT0000K0','100','D','2','4480',NULL,'STAD Cvgs',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvReasonCode','218','(''UA''=''T,'')','AZJTDT0000K0','2','D','2','4580',NULL,'Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvReasonEffDate','219','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4582',NULL,'Reason Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvEmpComments','220','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','4592',NULL,'Mbr Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvASOInd','221','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4642',NULL,'ASO Indicator Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLIFESmoker','222','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4643',NULL,'VLIF Emp Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLIFSpsSmoker','223','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4644',NULL,'VLIF Spouse Smoker',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvVLIFSpsDOB','224','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4645',NULL,'VLIF Spouse DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepFName1','225','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','4655',NULL,'Dep First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepLName1','226','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','4705',NULL,'Dep Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepMName1','227','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4755',NULL,'Dep M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepGender1','228','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4756',NULL,'Dep Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepDOB1','229','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4757',NULL,'Dep DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepRelationship','230','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4767',NULL,'Dep Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepStudent1','231','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4768',NULL,'Dep Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepCovInd1','233','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4769',NULL,'Dep Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepPCP1','234','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4779',NULL,'Dep DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepFName2','235','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','4809',NULL,'Dep 2 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepLName2','236','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','4859',NULL,'Dep 2 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepMName2','237','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4909',NULL,'Dep 2 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepGender2','238','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4910',NULL,'Dep 2 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepDOB2','239','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4911',NULL,'Dep 2 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepRelationship2','240','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4921',NULL,'Dep 2 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepStudent2','241','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','4922',NULL,'Dep 2 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepCovInd2','243','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','4923',NULL,'Dep 2 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepPCP2','244','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','4933',NULL,'Dep 2 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepFName3','245','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','4963',NULL,'Dep 3 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepLName3','246','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5013',NULL,'Dep 3 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepMName3','247','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5063',NULL,'Dep 3 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepGender3','248','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5064',NULL,'Dep 3 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepDOB3','249','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5065',NULL,'Dep 3 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepRelationship3','250','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5075',NULL,'Dep 3 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepStudent3','251','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5076',NULL,'Dep 3 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepCovInd3','253','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5077',NULL,'Dep 3 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepPCP3','254','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','5087',NULL,'Dep 3 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepFName4','255','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5117',NULL,'Dep 4 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepLName4','256','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5167',NULL,'Dep 4 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepMName4','257','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5217',NULL,'Dep 4 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepGender4','258','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5218',NULL,'Dep 4 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepDOB4','259','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5219',NULL,'Dep 4 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepRelationship4','260','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5229',NULL,'Dep 4 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepStudent4','261','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5230',NULL,'Dep 4 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepCovInd4','263','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5231',NULL,'Dep 4 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepPCP4','264','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','5241',NULL,'Dep 4 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepFName5','265','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5271',NULL,'Dep 5 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepLName','266','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5321',NULL,'Dep 5 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepMName5','267','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5371',NULL,'Dep 5 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepGender5','268','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5372',NULL,'Dep 5 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepDOB5','269','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5373',NULL,'Dep 5 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepRelationship5','270','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5383',NULL,'Dep 5 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepStudent5','271','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5384',NULL,'Dep 5 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepCovInd5','273','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5385',NULL,'Dep 5 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepPCP5','274','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','5395',NULL,'Dep 5 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepFName6','275','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5425',NULL,'Dep 6 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepLName6','276','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5475',NULL,'Dep 6 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepMName6','277','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5525',NULL,'Dep 6 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepGender6','278','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5526',NULL,'Dep 6 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepDOB6','279','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5527',NULL,'Dep 6 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepRelationship6','280','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5537',NULL,'Dep 6 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepStudent6','281','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5538',NULL,'Dep 6 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepCovInd6','283','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5539',NULL,'Dep 6 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepPCP6','284','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','5549',NULL,'Dep 6 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepFName7','285','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5425',NULL,'Dep 7 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepLName7','286','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5475',NULL,'Dep 7 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepMName7','287','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5525',NULL,'Dep 7 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepGender7','288','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5526',NULL,'Dep 7 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepDOB7','289','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5527',NULL,'Dep 7 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepRelationship7','290','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5537',NULL,'Dep 7 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepStudent7','291','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5538',NULL,'Dep 7 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepCovInd7','292','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5539',NULL,'Dep 7 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepPCP7','293','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','5549',NULL,'Dep 7 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepFName8','294','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5425',NULL,'Dep 8 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepLName8','295','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5475',NULL,'Dep 8 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepMName8','296','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5525',NULL,'Dep 8 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepGender8','297','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5526',NULL,'Dep 8 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepDOB8','298','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5527',NULL,'Dep 8 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepRelationship8','299','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5537',NULL,'Dep 8 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepStudent8','300','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5538',NULL,'Dep 8 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepCovInd8','301','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5539',NULL,'Dep 8 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepPCP8','302','(''UA''=''T,'')','AZJTDT0000K0','30','D','2','5549',NULL,'Dep 8 DHMO PCP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepFName9','303','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5425',NULL,'Dep 9 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepLName9','304','(''UA''=''T,'')','AZJTDT0000K0','50','D','2','5475',NULL,'Dep 9 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepMName9','305','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5525',NULL,'Dep 9 M I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepGender9','306','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5526',NULL,'Dep 9 Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepDOB9','307','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5527',NULL,'Dep 9 DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepRelationship9','308','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5537',NULL,'Dep 9 Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepStudent9','309','(''UA''=''T,'')','AZJTDT0000K0','1','D','2','5538',NULL,'Dep 9 Student Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepCovInd9','310','(''UA''=''T,'')','AZJTDT0000K0','10','D','2','5539',NULL,'Dep 9 Cvg Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('drvDepPCP9','311','(''UA''=''T'')','AZJTDT0000K0','30','D','2','5549',NULL,'Dep 9 DHMO PCP',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW33\Downloads\V10\Exports\TECHI\EmployeeHistoryExport\ELFGEDITEC_20180718.txt',NULL,'Null','N','8G9XQ,CYXVZ,VBDT5,VBSKH,W1EIB,W1EL1,Y0D25',NULL,NULL,NULL,'Lincoln Fina - wkly Mon 7:30p','201807181','EMPEXPORT','ELFGEDITEC','Jul 18 2018 11:30AM','ELFGEDITEC',NULL,NULL,NULL,'202004279','Jul 18 2018 12:00AM','Dec 30 1899 12:00AM','202004131','683','','','201806201',dbo.fn_GetTimedKey(),NULL,'ULTI_WPTECHI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW33\Downloads\V10\Exports\TECHI\EmployeeHistoryExport\TECHI_ELFGEDITEC_po20191217.txt',NULL,'','','Y0D25',NULL,NULL,NULL,'OE','202001311','EMPEXPORT','PASSIVEOE','Dec 17 2019  8:54AM','ELFGEDITEC',NULL,NULL,NULL,'202001311','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','769','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiTEC1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW33\Downloads\V10\Exports\TECHI\EmployeeHistoryExport\TECHI_ELFGEDITEC_ao20191226.txt',NULL,'','','',NULL,NULL,NULL,'OE','202001319','EMPEXPORT','ACTIVEOE','Dec 26 2019  4:30PM','ELFGEDITEC',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','710','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiTEC1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW3\EW33\Downloads\V10\Exports\TECHI\EmployeeHistoryExport\TECHI_ELFGEDITEC_20200409.txt',NULL,'','','',NULL,NULL,NULL,'TEST','202004099','EMPEXPORT','TEST','Apr 20 2020 12:42PM','ELFGEDITEC',NULL,NULL,NULL,'202004099','Apr  9 2020 12:00AM','Dec 30 1899 12:00AM','202003261','689','','','202003261',dbo.fn_GetTimedKey(),NULL,'us3lKiTEC1003',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','ExportDescription','C','Lincoln EDI file');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','InitialSort','C','drvESSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','MaxFileLength','C','5780');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','SystemID','V','AZJTDV0040K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELFGEDITEC','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' WHERE FormatCode = 'ELFGEDITEC' AND CfgName = 'ExportPath' AND CfgValue IS NULL;
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_ELFGEDITEC_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_ELFGEDITEC_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELFGEDITEC_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELFGEDITEC','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELFGEDITEC','D02','dbo.U_dsi_ELFGEDITEC_drvTbl',NULL);
IF OBJECT_ID('U_dsi_ELFGEDITEC_depTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELFGEDITEC_depTbl] (
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
IF OBJECT_ID('U_dsi_ELFGEDITEC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELFGEDITEC_drvTbl] (
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
    [drvPhoneBusiness] varchar(50) NULL,
    [drvBusinessExt] varchar(10) NULL,
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
    [drvLifeGrpAcctNo] varchar(18) NULL,
    [drvLifeEffDate] varchar(10) NULL,
    [drvLifePlanCode] varchar(1) NULL,
    [drvLifeClassCode] varchar(1) NULL,
    [drvLiveCvg] varchar(19) NULL,
    [drvWIGrpAcctNo] varchar(18) NULL,
    [drvWIEffDate] varchar(10) NULL,
    [drvWIPlanCode] varchar(1) NULL,
    [drvWIClassCode] varchar(1) NULL,
    [drvWICvg] varchar(4) NULL,
    [drvLTDGrpAcctNo] varchar(18) NULL,
    [drvLTDEffDate] varchar(10) NULL,
    [drvLTDPlanCode] varchar(1) NULL,
    [drvLTDClassCode] varchar(1) NULL,
    [drvLTDCvg] varchar(15) NULL,
    [drvDentGrpAcctNo] varchar(18) NULL,
    [drvDentEffDate] varchar(10) NULL,
    [drvDentPlanCode] varchar(1) NULL,
    [drvDentClassCode] varchar(1) NULL,
    [drvDentCvg] varchar(1) NOT NULL,
    [drvDentCvgTier] varchar(1) NOT NULL,
    [drvDentOtherIns] varchar(1) NULL,
    [drvDentTermDate] varchar(10) NULL,
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
    [drvVDNGrpAcctNo] varchar(18) NULL,
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
    [drvVLIFGrpAcctNo] varchar(18) NULL,
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
    [drvSTADACCNo] varchar(18) NULL,
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
    [drvDepFName1] varchar(100) NULL,
    [drvDepLName1] varchar(100) NULL,
    [drvDepMName1] varchar(1) NULL,
    [drvDepGender1] char(1) NULL,
    [drvDepDOB1] varchar(10) NULL,
    [drvDepRelationship] varchar(1) NULL,
    [drvDepStudent1] varchar(1) NOT NULL,
    [drvDepCovInd1] varchar(1) NULL,
    [drvDepDisabled1] char(1) NULL,
    [drvDepPCP1] varchar(1) NOT NULL,
    [drvDepFName2] varchar(100) NULL,
    [drvDepLName2] varchar(100) NULL,
    [drvDepMName2] varchar(1) NULL,
    [drvDepGender2] char(1) NULL,
    [drvDepDOB2] varchar(10) NULL,
    [drvDepRelationship2] varchar(1) NULL,
    [drvDepStudent2] varchar(1) NOT NULL,
    [drvDepCovInd2] varchar(1) NULL,
    [drvDepDisabled2] char(1) NULL,
    [drvDepPCP2] varchar(1) NOT NULL,
    [drvDepFName3] varchar(100) NULL,
    [drvDepLName3] varchar(100) NULL,
    [drvDepMName3] varchar(1) NULL,
    [drvDepGender3] char(1) NULL,
    [drvDepDOB3] varchar(10) NULL,
    [drvDepRelationship3] varchar(1) NULL,
    [drvDepStudent3] varchar(1) NOT NULL,
    [drvDepCovInd3] varchar(1) NULL,
    [drvDepDisabled3] char(1) NULL,
    [drvDepPCP3] varchar(1) NOT NULL,
    [drvDepFName4] varchar(100) NULL,
    [drvDepLName4] varchar(100) NULL,
    [drvDepMName4] varchar(1) NULL,
    [drvDepGender4] char(1) NULL,
    [drvDepDOB4] varchar(10) NULL,
    [drvDepRelationship4] varchar(1) NULL,
    [drvDepStudent4] varchar(1) NOT NULL,
    [drvDepCovInd4] varchar(1) NULL,
    [drvDepDisabled4] char(1) NULL,
    [drvDepPCP4] varchar(1) NOT NULL,
    [drvDepFName5] varchar(100) NULL,
    [drvDepLName] varchar(100) NULL,
    [drvDepMName5] varchar(1) NULL,
    [drvDepGender5] char(1) NULL,
    [drvDepDOB5] varchar(10) NULL,
    [drvDepRelationship5] varchar(1) NULL,
    [drvDepStudent5] varchar(1) NOT NULL,
    [drvDepCovInd5] varchar(1) NULL,
    [drvDepDisabled5] char(1) NULL,
    [drvDepPCP5] varchar(1) NOT NULL,
    [drvDepFName6] varchar(100) NULL,
    [drvDepLName6] varchar(100) NULL,
    [drvDepMName6] varchar(1) NULL,
    [drvDepGender6] char(1) NULL,
    [drvDepDOB6] varchar(10) NULL,
    [drvDepRelationship6] varchar(1) NULL,
    [drvDepStudent6] varchar(1) NOT NULL,
    [drvDepCovInd6] varchar(1) NULL,
    [drvDepDisabled6] char(1) NULL,
    [drvDepPCP6] varchar(1) NOT NULL,
    [drvDepFName7] varchar(100) NULL,
    [drvDepLName7] varchar(100) NULL,
    [drvDepMName7] varchar(1) NULL,
    [drvDepGender7] char(1) NULL,
    [drvDepDOB7] varchar(10) NULL,
    [drvDepRelationship7] varchar(1) NULL,
    [drvDepStudent7] varchar(1) NOT NULL,
    [drvDepCovInd7] varchar(1) NULL,
    [drvDepDisabled7] char(1) NULL,
    [drvDepPCP7] varchar(1) NOT NULL,
    [drvDepFName8] varchar(100) NULL,
    [drvDepLName8] varchar(100) NULL,
    [drvDepMName8] varchar(1) NULL,
    [drvDepGender8] char(1) NULL,
    [drvDepDOB8] varchar(10) NULL,
    [drvDepRelationship8] varchar(1) NULL,
    [drvDepStudent8] varchar(1) NOT NULL,
    [drvDepCovInd8] varchar(1) NULL,
    [drvDepDisabled8] char(1) NULL,
    [drvDepPCP8] varchar(1) NOT NULL,
    [drvDepFName9] varchar(100) NULL,
    [drvDepLName9] varchar(100) NULL,
    [drvDepMName9] varchar(1) NULL,
    [drvDepGender9] char(1) NULL,
    [drvDepDOB9] varchar(10) NULL,
    [drvDepRelationship9] varchar(1) NULL,
    [drvDepStudent9] varchar(1) NOT NULL,
    [drvDepCovInd9] varchar(1) NULL,
    [drvDepDisabled9] char(1) NULL,
    [drvDepPCP9] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ELFGEDITEC_volADDcovTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELFGEDITEC_volADDcovTbl] (
    [ceeid] char(12) NOT NULL,
    [ccoid] char(5) NOT NULL,
    [dcode] char(5) NOT NULL,
    [csort] varchar(1) NOT NULL,
    [ccov] varchar(37) NULL
);
IF OBJECT_ID('U_dsi_ELFGEDITEC_volcovTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELFGEDITEC_volcovTbl] (
    [ceeid] char(12) NOT NULL,
    [ccoid] char(5) NOT NULL,
    [dcode] char(5) NOT NULL,
    [csort] varchar(1) NOT NULL,
    [ccov] varchar(37) NULL
);
IF OBJECT_ID('U_ELFGEDITEC_EEList') IS NULL
CREATE TABLE [dbo].[U_ELFGEDITEC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELFGEDITEC_File') IS NULL
CREATE TABLE [dbo].[U_ELFGEDITEC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(6000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELFGEDITEC]
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
12/11/2019    Marco Lagrosa     TekP-2019-09-24-002             Updates to add DEHL dedcode added a few fields and change policy number
05/04/2020    Marco Lagrosa                                        Added more dependent from 6 to 9

_dsi_usp_ExportRipout 'ELFGEDITEC','Y', 'Y'

select * from dbo.U_dsi_Configuration where FormatCode = 'ELFGEDITEC' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'ELFGEDITEC'
select * from dbo.U_dsi_Parameters where FormatCode = 'ELFGEDITEC'
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELFGEDITEC' ORDER BY RunID DESC;


select * from AscDefH where AdhFormatCode = 'ELFGEDITEC'
select * from AscExp where expFormatCode = 'ELFGEDITEC'
select * from ascdeff where AdfHeaderSystemID = 'ELFGEDITECZ0' order by adfrectype, AdfSetNumber, AdfFieldNumber 

DSI_SP_TESTSWITCHBOX_V2 'ELFGEDITEC', 'ELFGEDITEC'
DSI_SP_TESTSWITCHBOX_V2 'ELFGEDITEC', 'TEST'
DSI_SP_TESTSWITCHBOX_V2 'ELFGEDITEC', 'ACTIVEOE'
DSI_SP_TESTSWITCHBOX_V2 'ELFGEDITEC', 'PASSIVEOE'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'ELFGEDITEC' AND CfgName = 'TESTING'

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
            delete dbo.u_ELFGEDITEC_EELIST
            from dbo.u_ELFGEDITEC_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T');

end;

--BDM
-- replace ELFGSELMOE with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','GLIFD, GLIFE, GLIFN, STD, LTD, LTDE, LIFEC, LIFEE, LIFES ,DENL');

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
FROM dbo.U_dsi_bdm_EmpDeductions with (nolock) WHERE eedformatcode = 'ELFGEDITEC' and eeddedcode = 'LIFEE')

--Spouse Voluntary Life to Spouse Voluntary AD&D
INSERT INTO dbo.U_dsi_bdm_EmpDeductions (eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, eeddedcode, eedvalidforexport, deddedcode, deddedtype)
     (select eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, 'VADDS', eedvalidforexport, 'VADDS', deddedtype
FROM dbo.U_dsi_bdm_EmpDeductions with (nolock) WHERE eedformatcode = 'ELFGEDITEC' and eeddedcode = 'LIFES')

--Child Voluntary Life to Child Voluntary AD&D
INSERT INTO dbo.U_dsi_bdm_EmpDeductions (eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, eeddedcode, eedvalidforexport, deddedcode, deddedtype)
     (select eedformatcode, eedcoid, eedeeid, eedbenamt, eedbenoption, eedbenstatus, eedbenstartdate, eedbenstopdate, 'VADDC', eedvalidforexport, 'VADDC', deddedtype
FROM dbo.U_dsi_bdm_EmpDeductions with (nolock) WHERE eedformatcode = 'ELFGEDITEC' and eeddedcode = 'LIFEC')



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
            delete dbo.u_ELFGEDITEC_eelist
            from dbo.u_ELFGEDITEC_eelist a
            where not exists(select 1 from U_dsi_bdm_EmpDeductions
                            where a.xeeid = eedeeid
                            and a.xcoid = eedcoid
                            and eedformatcode = @formatcode
                            and eedvalidforexport = 'Y');

-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_ELFGEDITEC_EELIST
            from dbo.u_ELFGEDITEC_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T');

            delete dbo.u_ELFGEDITEC_eelist
            from dbo.u_ELFGEDITEC_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ELFGEDITEC_eelist b where a.xeeid = b.xeeid
            having count(*) > 1);
end;

--Remove Test employees
delete dbo.u_ELFGEDITEC_eelist 
from dbo.u_ELFGEDITEC_eelist 
--join empcomp on eeccoid = xcoid and eeceeid = xeeid 
join emppers on eepeeid = xeeid 
where eepnamelast = 'TEST'

--Remove Employee type 'TEST' --Per PA-0000204989
delete dbo.u_ELFGEDITEC_eelist 
from dbo.u_ELFGEDITEC_eelist 
join empcomp on eeccoid = xcoid and eeceeid = xeeid 
--join emppers on eepeeid = xeeid 
where eeceetype = 'TES'

--Remove Part-time employees --Per PA-0000204989
delete dbo.u_ELFGEDITEC_eelist 
from dbo.u_ELFGEDITEC_eelist 
join empcomp on eeccoid = xcoid and eeceeid = xeeid 
--join emppers on eepeeid = xeeid 
where eecfulltimeorparttime = 'P'

--Remove owners Charlie Newell and Henry Newell --Per PA-0000204989
delete dbo.u_ELFGEDITEC_eelist 
from dbo.u_ELFGEDITEC_eelist 
--join empcomp on eeccoid = xcoid and eeceeid = xeeid 
join emppers on eepeeid = xeeid 
where eepnamelast = 'NEWELL' and eepnamefirst in ('Charlie','Henry')
       

--use this section of code up above the DRV table for Employees:
--select * from codes where codtable = 'relation'
if object_id('U_dsi_ELFGEDITEC_depTbl') is not null
    drop table dbo.U_dsi_ELFGEDITEC_depTbl;

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

into dbo.U_dsi_ELFGEDITEC_depTbl
from dbo.u_dsi_bdm_DepDeductions
    join contacts on dbndeprecid = consystemid
where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y';

--select * from dbo.U_dsi_ELFGEDITEC_depTbl

with mytemptable
as
(
select *, row_number()over(partition by drveeid order by cDoB) as rnk
from dbo.U_dsi_ELFGEDITEC_depTbl
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
if object_id('dbo.U_dsi_ELFGEDITEC_volcovTbl') is not null
  drop table dbo.U_dsi_ELFGEDITEC_volcovTbl;

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

  into dbo.U_dsi_ELFGEDITEC_volcovTbl
  from U_dsi_bdm_EmpDeductions  with (nolock)
    join dbo.u_dsi_bdm_BenCalculationAmounts on eedeeid = bcaeeid and eedcoid = bcacoid
        and eedFormatCode = bcaFormatCode and eeddedcode = bcadedcode
        and BcaDepRecID is null
  where eeddedcode IN ('LIFEE','LIFEC','LIFES')
    and eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
  order by ceeid, ccoid, csort;

--select * from U_dsi_ELFGEDITEC_volcovTbl

if object_id('dbo.U_dsi_ELFGEDITEC_volADDcovTbl') is not null
  drop table dbo.U_dsi_ELFGEDITEC_volADDcovTbl;

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

  into dbo.U_dsi_ELFGEDITEC_volADDcovTbl
  from U_dsi_bdm_EmpDeductions  with (nolock)
    join dbo.u_dsi_bdm_BenCalculationAmounts on eedeeid = bcaeeid and eedcoid = bcacoid
        and eedFormatCode = bcaFormatCode and eeddedcode = bcadedcode
        and BcaDepRecID is null
  where eeddedcode IN ('VADDE','VADDS','VADDC')
    and eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
  order by ceeid, ccoid, csort;

--select * from U_dsi_ELFGEDITEC_volcovTbl

-- Populate Source for Employees

if object_id('U_dsi_ELFGEDITEC_drvTbl') is not null
  drop table dbo.U_dsi_ELFGEDITEC_drvTbl;

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
    drvAppSignDate  =  case when denhl.startd is not null then CONVERT(varchar(10), dbo.dsi_fnGetMinMaxDates('MAX', denhl.startd, eecdateoflasthire), 101)
                          when wi.startd is not null then CONVERT(varchar(10), dbo.dsi_fnGetMinMaxDates('MAX', wi.startd, eecdateoflasthire) , 101)
                          when cd.effdate is not null then CONVERT(varchar(10), dbo.dsi_fnGetMinMaxDates('MAX', cd.effdate, eecdateoflasthire) , 101) 
                          when vl.effdate is not null then CONVERT(varchar(10), dbo.dsi_fnGetMinMaxDates('MAX', vl.effdate, eecdateoflasthire) , 101)
                          when dhmo.startd is not null then CONVERT(varchar(10), dbo.dsi_fnGetMinMaxDates('MAX', dhmo.startd, eecdateoflasthire) , 101) 
                          when den.startd is not null then CONVERT(varchar(10), dbo.dsi_fnGetMinMaxDates('MAX', den.startd, eecdateoflasthire) , 101) 
                          when ladd.date is not null then CONVERT(varchar(10), dbo.dsi_fnGetMinMaxDates('MAX',  ladd.date, eecdateoflasthire), 101) 
                          else CONVERT(varchar(10), (select max(eedbenstartdate) from U_dsi_bdm_EmpDeductions where eedeeid = xeeid), 101) 
                      End,    --2/23/17 CONVERT(varchar(10),eecUDField08, 101),--eecDateOfLastHire
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
    --drvDentPolicyNumber = den.acct,
    drvDentGrpAcctNo = denhl.sortgroup,
    drvDentEffDate = CONVERT(varchar(10), denhl.startd, 101),
    drvDentPlanCode = denhl.planc,
    drvDentClassCode = denhl.class,
    drvDentCvg = '',
    drvDentCvgTier = case when denhl.tier in ('EE','EEO') then '1'
                        when denhl.tier in ('EES','EEDP') then '2'
                        when denhl.tier in ('EEC') then '3'
                        when denhl.tier in ('EEF','EEDPF','FAM') then '4'
                    else '' end,
--more dental (n/a)
    drvDentOtherIns = denhl.denotheroption,
    drvDentTermDate = CONVERT(varchar(10), denhl.stopd, 101),
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
    drvDepFName1 = Dep1NameFirst,--d1.fname,
    drvDepLName1 = Dep1NameLAST,--d1.lname,
    drvDepMName1 = Dep1NameMiddle,--d1.MName,
    drvDepGender1 = Dep1Gender,--d1.conGender,
    drvDepDOB1 = CONVERT(varchar(10), Dep1Dob, 101) ,--convert(char(10),d1.cDoB,101),
    drvDepRelationship = CASE WHEN Dep1Relationship IS NOT NULL THEN 
                    CASE WHEN Dep1Relationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                    END,--d1.cRel,
    drvDepStudent1 = CASE WHEN ISNULL(DENLDEP.Dep1Relationship, '') <> '' AND Dep1Relationship IN ('CHL', 'DAU', 'DIS','DPC','GRC','SON','STC') THEN 'N' ELSE '' END, --CASE WHEN Dep1Relationship IS NOT NULL THEN 'Y' END,--d1.cstudent,
    drvDepCovInd1 = CASE WHEN Dep1NameFirst IS NOT NULL THEN 'D' END ,
    drvDepDisabled1 = Dep1IsDisabled,
    drvDepPCP1 = '',
    drvDepFName2 = Dep2NameFirst,--d2.fname,
    drvDepLName2 = Dep2NameLast,--d2.lname,
    drvDepMName2 = Dep2NameMiddle,--d2.MName,
    drvDepGender2 = Dep2Gender,--d2.conGender,
    drvDepDOB2 = CONVERT(varchar(10), Dep2Dob, 101),--convert(char(10),d2.cDoB,101),
    drvDepRelationship2 = CASE WHEN Dep2Relationship IS NOT NULL THEN 
                    CASE WHEN Dep2Relationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                    END,--d2.cRel,
    drvDepStudent2 = CASE WHEN ISNULL(DENLDEP.Dep2Relationship, '') <> '' AND Dep2Relationship IN ('CHL', 'DAU', 'DIS','DPC','GRC','SON','STC') THEN 'N' ELSE '' END, --CASE WHEN Dep2Relationship IS NOT NULL THEN 'Y' END,--d2.cstudent,
    drvDepCovInd2 =  CASE WHEN Dep2NameFirst IS NOT NULL THEN 'D' END,
    drvDepDisabled2 = Dep2IsDisabled,
    drvDepPCP2 = '',
    drvDepFName3 = Dep3NameFirst,--d3.fname,
    drvDepLName3 = Dep3NameLast,--d3.lname,
    drvDepMName3 = Dep3NameMiddle,--d3.MName,
    drvDepGender3 = Dep3Gender,--d3.conGender,
    drvDepDOB3 = CONVERT(varchar(10), Dep3Dob, 101),--convert(char(10),d3.cDoB,101),
    drvDepRelationship3 =CASE WHEN Dep3Relationship IS NOT NULL THEN 
                    CASE WHEN Dep3Relationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                    END,--d3.cRel,
    drvDepStudent3 = CASE WHEN ISNULL(DENLDEP.Dep3Relationship, '') <> '' AND Dep3Relationship IN ('CHL', 'DAU', 'DIS','DPC','GRC','SON','STC') THEN 'N' ELSE '' END, --CASE WHEN Dep3Relationship IS NOT NULL THEN 'Y' END,--d3.cstudent,
    drvDepCovInd3 =  CASE WHEN Dep3NameFirst IS NOT NULL THEN 'D' END,
    drvDepDisabled3 = Dep3IsDisabled,
    drvDepPCP3 = '',
    drvDepFName4 = Dep4NameFirst,--d4.fname,
    drvDepLName4 = Dep4NameLast,--d4.lname,
    drvDepMName4 = Dep4NameMiddle,--d4.MName,
    drvDepGender4 = Dep4Gender,--d4.conGender,
    drvDepDOB4 = CONVERT(varchar(10), Dep4Dob, 101),--convert(char(10),d4.cDoB,101),
    drvDepRelationship4 = CASE WHEN Dep4Relationship IS NOT NULL THEN 
                    CASE WHEN Dep4Relationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                    END,--d4.cRel,
    drvDepStudent4 = CASE WHEN ISNULL(DENLDEP.Dep4Relationship, '') <> '' AND Dep4Relationship IN ('CHL', 'DAU', 'DIS','DPC','GRC','SON','STC') THEN 'N' ELSE '' END,--CASE WHEN Dep4Relationship IS NOT NULL THEN 'Y' END,--d4.cstudent,
    drvDepCovInd4 =  CASE WHEN Dep4NameFirst IS NOT NULL THEN 'D' END,
    drvDepDisabled4 = Dep4IsDisabled,
    drvDepPCP4 = '',
    drvDepFName5 = Dep5NameFirst,--d5.fname,
    drvDepLName = Dep5NameLast,--d5.lname,
    drvDepMName5 = Dep5NameMiddle,--d5.MName,
    drvDepGender5 = Dep5Gender,--d5.conGender,
    drvDepDOB5 = CONVERT(varchar(10), Dep5Dob, 101),--convert(char(10),d5.cDoB,101),
    drvDepRelationship5 = CASE WHEN Dep5Relationship IS NOT NULL THEN 
                    CASE WHEN Dep5Relationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                    END,--d5.cRel,
    drvDepStudent5 = CASE WHEN ISNULL(DENLDEP.Dep5Relationship, '') <> '' AND Dep5Relationship IN ('CHL', 'DAU', 'DIS','DPC','GRC','SON','STC') THEN 'N' ELSE '' END, --CASE WHEN Dep5Relationship IS NOT NULL THEN 'Y' END,--d5.cstudent,
    drvDepCovInd5 =  CASE WHEN Dep5NameFirst IS NOT NULL THEN 'D' END,
    drvDepDisabled5 = Dep5IsDisabled,
    drvDepPCP5 = '',
    drvDepFName6 = Dep6NameFirst,--d6.fname,
    drvDepLName6 = Dep6NameLast,--d6.lname,
    drvDepMName6 = Dep6NameMiddle,--d6.MName,
    drvDepGender6 = Dep6Gender,--d6.conGender,
    drvDepDOB6 = CONVERT(varchar(10), Dep6Dob, 101),--convert(char(10),d6.cDoB,101),
    drvDepRelationship6 = CASE WHEN Dep6Relationship IS NOT NULL THEN 
                    CASE WHEN Dep6Relationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                    END,--d6.cRel,
    drvDepStudent6 = CASE WHEN ISNULL(DENLDEP.Dep6Relationship, '') <> '' AND Dep6Relationship IN ('CHL', 'DAU', 'DIS','DPC','GRC','SON','STC') THEN 'N' ELSE '' END, --CASE WHEN Dep6Relationship IS NOT NULL THEN 'Y' END,--d6.cstudent,
    drvDepCovInd6 =  CASE WHEN Dep6NameFirst IS NOT NULL THEN 'D' END,
    drvDepDisabled6 = Dep6IsDisabled,
    drvDepPCP6 = '',
    
    drvDepFName7 = Dep7NameFirst,--d6.fname,
    drvDepLName7 = Dep7NameLast,--d6.lname,
    drvDepMName7 = Dep7NameMiddle,--d6.MName,
    drvDepGender7 = Dep7Gender,--d6.conGender,
    drvDepDOB7 = CONVERT(varchar(10), Dep7Dob, 101),--convert(char(10),d6.cDoB,101),
    drvDepRelationship7 = CASE WHEN Dep7Relationship IS NOT NULL THEN 
                    CASE WHEN Dep7Relationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                    END,--d6.cRel,
    drvDepStudent7 = CASE WHEN ISNULL(DENLDEP.Dep7Relationship, '') <> '' AND Dep7Relationship IN ('CHL', 'DAU', 'DIS','DPC','GRC','SON','STC') THEN 'N' ELSE '' END, --CASE WHEN Dep6Relationship IS NOT NULL THEN 'Y' END,--d6.cstudent,
    drvDepCovInd7 =  CASE WHEN Dep7NameFirst IS NOT NULL THEN 'D' END,
    drvDepDisabled7 = Dep7IsDisabled,
    drvDepPCP7 = '',
    
    drvDepFName8 = Dep8NameFirst,--d6.fname,
    drvDepLName8 = Dep8NameLast,--d6.lname,
    drvDepMName8 = Dep8NameMiddle,--d6.MName,
    drvDepGender8 = Dep8Gender,--d6.conGender,
    drvDepDOB8 = CONVERT(varchar(10), Dep8Dob, 101),--convert(char(10),d6.cDoB,101),
    drvDepRelationship8 = CASE WHEN Dep8Relationship IS NOT NULL THEN 
                    CASE WHEN Dep8Relationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                    END,--d6.cRel,
    drvDepStudent8 = CASE WHEN ISNULL(DENLDEP.Dep8Relationship, '') <> '' AND Dep8Relationship IN ('CHL', 'DAU', 'DIS','DPC','GRC','SON','STC') THEN 'N' ELSE '' END, --CASE WHEN Dep6Relationship IS NOT NULL THEN 'Y' END,--d6.cstudent,
    drvDepCovInd8 =  CASE WHEN Dep8NameFirst IS NOT NULL THEN 'D' END,
    drvDepDisabled8 = Dep8IsDisabled,
    drvDepPCP8 = '' ,
    drvDepFName9 = Dep9NameFirst,--d6.fname,
    drvDepLName9 = Dep9NameLast,--d6.lname,
    drvDepMName9 = Dep9NameMiddle,--d6.MName,
    drvDepGender9 = Dep9Gender,--d6.conGender,
    drvDepDOB9 = CONVERT(varchar(10), Dep9Dob, 101),--convert(char(10),d6.cDoB,101),
    drvDepRelationship9 = CASE WHEN Dep9Relationship IS NOT NULL THEN 
                    CASE WHEN Dep9Relationship IN ('SPS','DP') THEN 'S' ELSE 'C' END
                    END,--d6.cRel,
    drvDepStudent9 = CASE WHEN ISNULL(DENLDEP.Dep9Relationship, '') <> '' AND Dep9Relationship IN ('CHL', 'DAU', 'DIS','DPC','GRC','SON','STC') THEN 'N' ELSE '' END, --CASE WHEN Dep6Relationship IS NOT NULL THEN 'Y' END,--d6.cstudent,
    drvDepCovInd9 =  CASE WHEN Dep9NameFirst IS NOT NULL THEN 'D' END,
    drvDepDisabled9 = Dep9IsDisabled,
    drvDepPCP9 = ''  

  into dbo.U_dsi_ELFGEDITEC_drvTbl
  from dbo.u_ELFGEDITEC_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join jobcode with (nolock) on eecJobCode = jbcJobCode
    left join (select ejheeid, ejhcoid, max(ejhjobeffdate) saleffdate
        from emphjob where ejhisratechange = 'Y' group by ejheeid,ejhcoid) jh on jh.ejheeid = xeeid and jh.ejhcoid = xcoid
--LI/AD
    left join (select distinct eedeeid eeid, eedcoid coid, 
    case 
    when rtrim(eecpaygroup) = 'CRP' then '1643665-CORPORATE'
    when rtrim(eecpaygroup) = 'OLA' then '1643665-NKC'
    when rtrim(eecpaygroup) = 'GRV' then '1643665-GROVE'
    when rtrim(eecpaygroup) = 'OWS' then '1643665-OWASSO'
    when rtrim(eecpaygroup) = 'CHA' then '1643665-CHANUTE'
    when rtrim(eecpaygroup) = 'CHP' then '1643665-PROCESSING'
    when rtrim(eecpaygroup) = 'STL' then '1643665-ST. LOUIS'
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
    when rtrim(eecpaygroup)= 'CRP' then '1643665-CORPORATE'
    when rtrim(eecpaygroup)= 'OLA' then '1643665-NKC'
    when rtrim(eecpaygroup)= 'GRV' then '1643665-GROVE'
    when rtrim(eecpaygroup)= 'OWS' then '1643665-OWASSO'
    when rtrim(eecpaygroup)= 'CHA' then '1643665-CHANUTE'
    when rtrim(eecpaygroup)= 'CHP' then '1643665-PROCESSING'
    when rtrim(eecpaygroup)= 'STL' then '1643665-ST. LOUIS'
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
    when rtrim(eecpaygroup)= 'CRP' then '1643665-CORPORATE'
    when rtrim(eecpaygroup)= 'OLA' then '1643665-NKC'
    when rtrim(eecpaygroup)= 'GRV' then '1643665-GROVE'
    when rtrim(eecpaygroup)= 'OWS' then '1643665-OWASSO'
    when rtrim(eecpaygroup)= 'CHA' then '1643665-CHANUTE'
    when rtrim(eecpaygroup)= 'CHP' then '1643665-PROCESSING'
    when rtrim(eecpaygroup)= 'STL' then '1643665-ST. LOUIS'
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
--DENHL

    left join (select eedeeid eeid, eedcoid coid, '00001D040068-00000' acct,'1643665' as location,
    case 
    when rtrim(eecpaygroup) = 'CRP' then '1643665-CORPORATE'
    when rtrim(eecpaygroup) = 'OLA' then '1643665-NKC'
    when rtrim(eecpaygroup) = 'GRV' then '1643665-GROVE'
    when rtrim(eecpaygroup) = 'OWS' then '1643665-OWASSO'
    when rtrim(eecpaygroup) = 'CHA' then '1643665-CHANUTE'
    when rtrim(eecpaygroup) = 'CHP' then '1643665-PROCESSING'
    when rtrim(eecpaygroup) = 'STL' then '1643665-ST. LOUIS'
    end sortgroup,
    eedBenStartDate startd, 
    eedBenStopDate stopd,
    CASE WHEN eecsalaryorhourly = 'S' then '1' Else '2' END planc, 
    CASE WHEN eecsalaryorhourly = 'S' then '1' Else '2' END class,
    '' cvg, eedbenoption tier, 'U' denotheroption
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eedeeid = eeceeid and eedcoid = eeccoid where eeddedcode IN ('DENL') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') denhl on denhl.eeid = xeeid and denhl.coid = xcoid
--DEN
left join (select eedeeid eeid, eedcoid coid, '00001D040068-00000' acct,'1643665' as location,
    case 
    when rtrim(eecpaygroup) = 'CRP' then '1643665-CORPORATE'
    when rtrim(eecpaygroup) = 'OLA' then '1643665-NKC'
    when rtrim(eecpaygroup) = 'GRV' then '1643665-GROVE'
    when rtrim(eecpaygroup) = 'OWS' then '1643665-OWASSO'
    when rtrim(eecpaygroup) = 'CHA' then '1643665-CHANUTE'
    when rtrim(eecpaygroup) = 'CHP' then '1643665-PROCESSING'
    when rtrim(eecpaygroup) = 'STL' then '1643665-ST. LOUIS'
    end sortgroup,
    eedBenStartDate startd, 
    eedBenStopDate stopd,
    '1' planc, 
    CASE WHEN (select top 1 EjhFLSACategory from EmpHJob where ejheeid = eeceeid and ejhcoid = eeccoid  order by EjhDateTimeCreated)   = 'E' THEN '1' ELSE '2' END class,
    'VDN' cvg, eedbenoption tier, 'U' denotheroption
        from dbo.U_dsi_bdm_EmpDeductions join empcomp on eedeeid = eeceeid and eedcoid = eeccoid where eeddedcode IN ('XXXXX') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') den on den.eeid = xeeid and den.coid = xcoid

--DHMO
    left join (select eedeeid eeid, eedcoid coid, '1541445' acct, eedBenStartDate startd, '1' planc, '1' class, 'DHMO' cvg, eedbenoption tier
        from dbo.U_dsi_bdm_EmpDeductions where eeddedcode IN ('XXXXX') and eedFormatCode = @FormatCode and eedValidForExport = 'Y') dhmo on dhmo.eeid = xeeid and dhmo.coid = xcoid
--VC
    left join (select ceeid eeid, ccoid coid,count(csort) as vccount from dbo.U_dsi_ELFGEDITEC_volcovTbl
                group by ceeid,ccoid) VC on VC.eeid = xeeid and VC.coid = xcoid
--VC
    left join (select ceeid eeid, ccoid coid,count(csort) as vccount from dbo.U_dsi_ELFGEDITEC_volADDcovTbl
                group by ceeid,ccoid) VAD on VAD.eeid = xeeid and VAD.coid = xcoid
--C1-C5 for VLIF Coverages
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDITEC_volcovTbl) C1 on C1.eeid = xeeid and C1.coid = xcoid and C1.Cno = '1'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDITEC_volcovTbl) C2 on C2.eeid = xeeid and C2.coid = xcoid and C2.Cno = '2'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDITEC_volcovTbl) C3 on C3.eeid = xeeid and C3.coid = xcoid and C3.Cno = '3'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDITEC_volcovTbl) C4 on C4.eeid = xeeid and C4.coid = xcoid and C4.Cno = '4'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDITEC_volcovTbl) C5 on C5.eeid = xeeid and C5.coid = xcoid and C5.Cno = '5'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDITEC_volcovTbl) C6 on C6.eeid = xeeid and C6.coid = xcoid and C6.Cno = '6'
--AD1-AD3 for VAD Coverages
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDITEC_volADDcovTbl) AD1 on AD1.eeid = xeeid and AD1.coid = xcoid and AD1.Cno = '1'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDITEC_volADDcovTbl) AD2 on AD2.eeid = xeeid and AD2.coid = xcoid and AD2.Cno = '2'
    left join (select ceeid eeid, ccoid coid, csort, ccov cvg,row_number()
        over (partition by ceeid order by csort) cNo
        from dbo.U_dsi_ELFGEDITEC_volADDcovTbl) AD3 on AD3.eeid = xeeid and AD3.coid = xcoid and AD3.Cno = '3'
--VL
    left join (select eedeeid eeid, eedcoid coid, 
    case 
    when rtrim(eecpaygroup)= 'CRP' then '1643665-CORPORATE'
    when rtrim(eecpaygroup)= 'OLA' then '1643665-NKC'
    when rtrim(eecpaygroup)= 'GRV' then '1643665-GROVE'
    when rtrim(eecpaygroup)= 'OWS' then '1643665-OWASSO'
    when rtrim(eecpaygroup)= 'CHA' then '1643665-CHANUTE'
    when rtrim(eecpaygroup)= 'CHP' then '1643665-PROCESSING'
    when rtrim(eecpaygroup)= 'STL' then '1643665-ST. LOUIS'
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
    when rtrim(eecpaygroup)= 'CRP' then '1643666-CORPORATE'
    when rtrim(eecpaygroup)= 'OLA' then '1643666-NKC'
    when rtrim(eecpaygroup)= 'GRV' then '1643666-GROVE'
    when rtrim(eecpaygroup)= 'OWS' then '1643666-OWASSO'
    when rtrim(eecpaygroup)= 'CHA' then '1643666-CHANUTE'
    when rtrim(eecpaygroup)= 'CHP' then '1643666-PROCESSING'
    when rtrim(eecpaygroup)= 'STL' then '1643666-ST. LOUIS'
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
    when rtrim(eecpaygroup)= 'CRP' then '1643665-CORPORATE'
    when rtrim(eecpaygroup)= 'OLA' then '1643665-NKC'
    when rtrim(eecpaygroup)= 'GRV' then '1643665-GROVE'
    when rtrim(eecpaygroup)= 'OWS' then '1643665-OWASSO'
    when rtrim(eecpaygroup)= 'CHA' then '1643665-CHANUTE'
    when rtrim(eecpaygroup)= 'CHP' then '1643665-PROCESSING'
    when rtrim(eecpaygroup)= 'STL' then '1643665-ST. LOUIS'
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
    when rtrim(eecpaygroup)= 'CRP' then '1643666-CORPORATE'
    when rtrim(eecpaygroup)= 'OLA' then '1643666-NKC'
    when rtrim(eecpaygroup)= 'GRV' then '1643666-GROVE'
    when rtrim(eecpaygroup)= 'OWS' then '1643666-OWASSO'
    when rtrim(eecpaygroup)= 'CHA' then '1643666-CHANUTE'
    when rtrim(eecpaygroup)= 'CHP' then '1643666-PROCESSING'
    when rtrim(eecpaygroup)= 'STL' then '1643666-ST. LOUIS'
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
    when rtrim(eecpaygroup)= 'CRP' then '1643665-CORPORATE'
    when rtrim(eecpaygroup)= 'OLA' then '1643665-NKC'
    when rtrim(eecpaygroup)= 'GRV' then '1643665-GROVE'
    when rtrim(eecpaygroup)= 'OWS' then '1643665-OWASSO'
    when rtrim(eecpaygroup)= 'CHA' then '1643665-CHANUTE'
    when rtrim(eecpaygroup)= 'CHP' then '1643665-PROCESSING'
    when rtrim(eecpaygroup)= 'STL' then '1643665-ST. LOUIS'
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
    when rtrim(eecpaygroup)= 'CRP' then '1643665-CORPORATE'
    when rtrim(eecpaygroup)= 'OLA' then '1643665-NKC'
    when rtrim(eecpaygroup)= 'GRV' then '1643665-GROVE'
    when rtrim(eecpaygroup)= 'OWS' then '1643665-OWASSO'
    when rtrim(eecpaygroup)= 'CHA' then '1643665-CHANUTE'
    when rtrim(eecpaygroup)= 'CHP' then '1643665-PROCESSING'
    when rtrim(eecpaygroup)= 'STL' then '1643665-ST. LOUIS'
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
--Depedent for Dental
    LEFT JOIN (
        Select dbneeid,dbncoid,
        Max(case when depId = 1 then ConNameFirst END) as Dep1NameFirst,
        Max(case when depId = 1 then ConNameLast END) as Dep1NameLast,
        Max(case when depId = 1 then LEFT(ISNULL(ConNameMiddle,''),1) END) as Dep1NameMiddle,    
        Max(case when depId = 1 then ConGender END) as Dep1Gender,
        Max(case when depId = 1 then ConDateOfBirth END) as Dep1Dob,
        Max(case when depId = 1 then ConRelationShip END) as Dep1Relationship,
        Max(case when depId = 1 then ConIsDisabled END) as Dep1IsDisabled,
        Max(case when depId = 2 then ConNameFirst END) as Dep2NameFirst,
        Max(case when depId = 2 then ConNameLast END) as Dep2NameLast,
        Max(case when depId = 2 then LEFT(ISNULL(ConNameMiddle,''),1) END) as Dep2NameMiddle,
        Max(case when depId = 2 then ConGender END) as Dep2Gender,
        Max(case when depId = 2 then ConDateOfBirth END) as Dep2Dob,
        Max(case when depId = 2 then ConRelationShip END) as Dep2Relationship,
        Max(case when depId = 2 then ConIsDisabled END) as Dep2IsDisabled,
        Max(case when depId = 3 then ConNameFirst END) as Dep3NameFirst,
        Max(case when depId = 3 then ConNameLast END) as Dep3NameLast,
        Max(case when depId = 3 then LEFT(ISNULL(ConNameMiddle,''),1) END) as Dep3NameMiddle,
        Max(case when depId = 3 then ConGender END) as Dep3Gender,
        Max(case when depId = 3 then ConDateOfBirth END) as Dep3Dob,
        Max(case when depId = 3 then ConRelationShip END) as Dep3Relationship,
        Max(case when depId = 3 then ConIsDisabled END) as Dep3IsDisabled,
        Max(case when depId = 4 then ConNameFirst END)as Dep4NameFirst,
        Max(case when depId = 4 then ConNameLast END) as Dep4NameLast,
        Max(case when depId = 4 then LEFT(ISNULL(ConNameMiddle,''),1) END) as Dep4NameMiddle,
        Max(case when depId = 4 then ConGender END) as Dep4Gender,
        Max(case when depId = 4 then ConDateOfBirth END) as Dep4Dob,
        Max(case when depId = 4 then ConRelationShip END) as Dep4Relationship,
        Max(case when depId = 4 then ConIsDisabled END) as Dep4IsDisabled,
        Max(case when depId = 5 then ConNameFirst END) as Dep5NameFirst,
        Max(case when depId = 5 then ConNameLast END) as Dep5NameLast,
        Max(case when depId = 5 then LEFT(ISNULL(ConNameMiddle,''),1) END) as Dep5NameMiddle,
        Max(case when depId = 5 then ConGender END) as Dep5Gender,
        Max(case when depId = 5 then ConDateOfBirth END) as Dep5Dob,
        Max(case when depId = 5 then ConRelationShip END) as Dep5Relationship,
        Max(case when depId = 5 then ConIsDisabled END) as Dep5IsDisabled,
        Max(case when depId = 6 then ConNameFirst END) as Dep6NameFirst ,
        Max(case when depId = 6 then ConNameLast END) as Dep6NameLast,
        Max(case when depId = 6 then LEFT(ISNULL(ConNameMiddle,''),1) END) as Dep6NameMiddle,
        Max(case when depId = 6 then ConGender END) as Dep6Gender,
        Max(case when depId = 6 then ConDateOfBirth END) as Dep6Dob,
        Max(case when depId = 6 then ConRelationShip END) as Dep6Relationship,
        Max(case when depId = 6 then ConIsDisabled END) as Dep6IsDisabled,
        Max(case when depId = 7 then ConNameFirst END) as Dep7NameFirst ,
        Max(case when depId = 7 then ConNameLast END) as Dep7NameLast,
        Max(case when depId = 7 then LEFT(ISNULL(ConNameMiddle,''),1) END) as Dep7NameMiddle,
        Max(case when depId = 7 then ConGender END) as Dep7Gender,
        Max(case when depId = 7 then ConDateOfBirth END) as Dep7Dob,
        Max(case when depId = 7 then ConRelationShip END) as Dep7Relationship,
        Max(case when depId = 7 then ConIsDisabled END) as Dep7IsDisabled,
        Max(case when depId = 8 then ConNameFirst END) as Dep8NameFirst,
        Max(case when depId = 8 then ConNameLast END) as Dep8NameLast,
        Max(case when depId = 8 then LEFT(ISNULL(ConNameMiddle,''),1) END) as Dep8NameMiddle,
        Max(case when depId = 8 then ConGender END) as Dep8Gender,
        Max(case when depId = 8 then ConDateOfBirth END) as Dep8Dob,
        Max(case when depId = 8 then ConRelationShip END) as Dep8Relationship,
        Max(case when depId = 8 then ConIsDisabled END) as Dep8IsDisabled,
        Max(case when depId = 9 then ConNameFirst END) as Dep9NameFirst,
        Max(case when depId = 9 then ConNameLast END) as Dep9NameLast,
        Max(case when depId = 9 then LEFT(ISNULL(ConNameMiddle,''),1) END) as Dep9NameMiddle,
        Max(case when depId = 9 then ConGender END) as Dep9Gender,
        Max(case when depId = 9 then ConDateOfBirth END) as Dep9Dob,
        Max(case when depId = 9 then ConRelationShip END) as Dep9Relationship,
        Max(case when depId = 9 then ConIsDisabled END) as Dep9IsDisabled
         from (
        select dbneeid,dbncoid, ConNameFirst,ConNameLast,ConNameMiddle,ConGender,ConDateOfBirth,ConRelationShip, ConIsDisabled, dbnDepRecId,ROW_NUMBER() OVER(PARTITION BY dbneeid ORDER BY dbnDepRecId ASC) As DepId from dbo.U_dsi_bdm_DepDeductions   LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = dbneeid
        AND ConSystemID = dbnDepRecId  where dbnFormatCode = @FormatCode and dbndedcode IN ('DENL')) as Source
        group by dbneeid,dbncoid) DENLDEP on DENLDEP.dbneeid = xeeid and DENLDEP.dbncoid = xcoid

    left join (select * from dbo.U_dsi_ELFGEDITEC_depTbl where cRel in ('S')) sps on sps.drveeid = xeeid and sps.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDITEC_depTbl where drvrank = '01') d1 on d1.drveeid = xeeid and d1.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDITEC_depTbl where drvrank = '02') d2 on d2.drveeid = xeeid and d2.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDITEC_depTbl where drvrank = '03') d3 on d3.drveeid = xeeid and d3.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDITEC_depTbl where drvrank = '04') d4 on d4.drveeid = xeeid and d4.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDITEC_depTbl where drvrank = '05') d5 on d5.drveeid = xeeid and d5.drvcoid = xcoid
    left join (select * from dbo.U_dsi_ELFGEDITEC_depTbl where drvrank = '06') d6 on d6.drveeid = xeeid and d6.drvcoid = xcoid

where exists (select 1 from dbo.U_dsi_bdm_EmpDeductions where eedeeid = xeeid and eedcoid = xcoid
                and eedFormatCode = @FormatCode and eedValidForExport = 'Y');

--Syed Salehin 10/25/16: Remove additional comma at the end of the drvvlifcvg column
update U_dsi_ELFGEDITEC_drvTbl set drvvlifcvg = substring(drvvlifcvg,1,len(drvvlifcvg)-1)
from dbo.U_dsi_ELFGEDITEC_drvTbl where right(ltrim(rtrim(drvvlifcvg)),1) = ','

--select * from dbo.U_dsi_ELFGEDITEC_volcovTbl order by ccov
--select * from dbo.U_ELFGEDITEC_DedData

----select drvVLIFCvg,* from dbo.U_dsi_ELFGEDITEC_drvTbl

--remove trailing comma
--update dbo.U_dsi_ELFGEDITEC_drvTbl
--    set drvVLIFCvg = substring(drvVLIFCvg,1,len(drvVLIFCvg) - 1)
--    where len(drvVLIFCvg) > 0

-- Set FileName
if (dbo.dsi_fnVariable('ELFGEDITEC','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'TECHI_LFG_' + convert(char(8),getdate(),112) + '.csv'
    where FormatCode = 'ELFGEDITEC';

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwELFGEDITEC_Export as
        select top 2000000 rtrim(Data) as Data
        from dbo.U_ELFGEDITEC_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)

select expformatcode, expexportcode, expstartpercontrol, expendpercontrol, *
from ascexp where expformatcode = 'ELFGEDITEC'    
*/

--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDITEC','ELFGEDITEC'
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDITEC','ACTIVEOE'
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDITEC','PASSIVEOE'
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDITEC','TEST'
--dbo.dsi_sp_TestSwitchbox_v2 'ELFGEDITEC','ZAP'

END
GO
Create View dbo.dsi_vwELFGEDITEC_Export as
        select top 2000000 rtrim(Data) as Data
        from dbo.U_ELFGEDITEC_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)