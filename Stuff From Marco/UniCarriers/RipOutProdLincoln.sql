SET NOCOUNT ON;
IF OBJECT_ID('U_ELILSLFEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELILSLFEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELILSLFEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELILSLFEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELILSLFEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELILSLFEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELILSLFEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELILSLFEXP];
GO
IF OBJECT_ID('U_ELILSLFEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ELILSLFEXP_Trailer];
GO
IF OBJECT_ID('U_ELILSLFEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELILSLFEXP_PEarHist];
GO
IF OBJECT_ID('U_ELILSLFEXP_Headerl') IS NOT NULL DROP TABLE [dbo].[U_ELILSLFEXP_Headerl];
GO
IF OBJECT_ID('U_ELILSLFEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ELILSLFEXP_File];
GO
IF OBJECT_ID('U_ELILSLFEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELILSLFEXP_EEList];
GO
IF OBJECT_ID('U_ELILSLFEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELILSLFEXP_drvTbl];
GO
IF OBJECT_ID('U_ELILSLFEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELILSLFEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ELILSLFEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELILSLFEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELILSLFEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELILSLFEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELILSLFEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELILSLFEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELILSLFEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELILSLFEXP','Lincoln STD LTD FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ELILSLFEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerId"','1','(''UA''=''F'')','ELILSLFEXPZ0','9','H','01','1',NULL,'Customer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordNumber"','2','(''UA''=''F'')','ELILSLFEXPZ0','7','H','01','2',NULL,'Record Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDate"','3','(''UD112''=''F'')','ELILSLFEXPZ0','10','H','01','3',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordLength"','4','(''UA''=''F'')','ELILSLFEXPZ0','7','H','01','4',NULL,'Record Length',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','ELILSLFEXPZ0','2966','H','01','5',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordDelimiter"','6','(''UA''=''F'')','ELILSLFEXPZ0','1','H','01','6',NULL,'Record Delimiter',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountdIdNumber"','2','(''UA''=''F'')','ELILSLFEXPZ0','6','D','10','2',NULL,'iCAM Account ID Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountVerificationNumber"','3','(''UA''=''F'')','ELILSLFEXPZ0','6','D','10','3',NULL,'iCAM Account Verification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabilityCustomerId"','4','(''UA''=''F'')','ELILSLFEXPZ0','9','D','10','4',NULL,'Disability Customer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','5',NULL,'Account Specific Organization 1 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','6',NULL,'Account Specific Organization 2 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','7',NULL,'Account Specific Organization 3 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','8',NULL,'Account Specific Organization 4 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','9',NULL,'Account Specific Organization 5 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','10',NULL,'Account Specific Organization 6 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','11',NULL,'Account Specific Organization 7 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','12',NULL,'Account Specific Organization 8 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','13',NULL,'Account Specific Organization 9 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','14',NULL,'Account Specific Organization 10 Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','15',NULL,'WC Insured Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabilitySubsidiaryCode"','16','(''UA''=''F'')','ELILSLFEXPZ0','4','D','10','16',NULL,'Disability Subsidiary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','17',NULL,'Organizational Structure I',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','18',NULL,'Organizational Structure II',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','ELILSLFEXPZ0','10','D','10','19',NULL,'Current Division Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''F'')','ELILSLFEXPZ0','10','D','10','20',NULL,'Current Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''F'')','ELILSLFEXPZ0','10','D','10','21',NULL,'Current Position Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','22',NULL,'Disability Contact Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''F'')','ELILSLFEXPZ0','35','D','10','23',NULL,'Disability Contact First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''F'')','ELILSLFEXPZ0','35','D','10','24',NULL,'Disability Contact Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','25',NULL,'Disability Contact Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','26',NULL,'Disability Contact Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','27',NULL,'Disability Contact Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''SS''=''F'')','ELILSLFEXPZ0','20','D','10','28',NULL,'Disability Contact Address City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''SS''=''F'')','ELILSLFEXPZ0','2','D','10','29',NULL,'Disability Contact Address  State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''SS''=''F'')','ELILSLFEXPZ0','9','D','10','30',NULL,'Disability Contact Address Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''F'')','ELILSLFEXPZ0','3','D','10','31',NULL,'Disability Contact Address Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''F'')','ELILSLFEXPZ0','100','D','10','32',NULL,'Disability Contact Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''SS''=''F'')','ELILSLFEXPZ0','3','D','10','33',NULL,'Disability Contact Telephone Area Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''SS''=''F'')','ELILSLFEXPZ0','3','D','10','34',NULL,'Disability Contact Telephone Exchange Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''F'')','ELILSLFEXPZ0','4','D','10','35',NULL,'Disability Contact Telephone Line Range Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''F'')','ELILSLFEXPZ0','8','D','10','36',NULL,'Disability Contact Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''F'')','ELILSLFEXPZ0','35','D','10','37',NULL,'Supervisor First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''F'')','ELILSLFEXPZ0','35','D','10','38',NULL,'Supervisor Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','39',NULL,'Supervisor Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','40',NULL,'Supervisor Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''F'')','ELILSLFEXPZ0','3','D','10','41',NULL,'Supervisor Telephone Area Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''F'')','ELILSLFEXPZ0','3','D','10','42',NULL,'Supervisor Telephone Exchange Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''F'')','ELILSLFEXPZ0','4','D','10','43',NULL,'Supervisor Telephone Line Range Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIdentification"','44','(''UA''=''F'')','ELILSLFEXPZ0','11','D','10','44',NULL,'Employee Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','45','(''UA''=''F'')','ELILSLFEXPZ0','2','D','10','45',NULL,'Employment State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabilityLocationCode"','46','(''UA''=''F'')','ELILSLFEXPZ0','8','D','10','46',NULL,'Disability Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''F'')','ELILSLFEXPZ0','15','D','10','47',NULL,'Employee Department Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''F'')','ELILSLFEXPZ0','4','D','10','48',NULL,'Occupation Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationDesc"','49','(''UA''=''F'')','ELILSLFEXPZ0','50','D','10','49',NULL,'Occupation Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','50',NULL,'Physical Demands Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','51','(''UA''=''F'')','ELILSLFEXPZ0','35','D','10','51',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','52','(''UA''=''F'')','ELILSLFEXPZ0','35','D','10','52',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddileInitial"','53','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','53',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','54',NULL,'Employee Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','55','(''UA''=''F'')','ELILSLFEXPZ0','30','D','10','55',NULL,'Employee Address Line 1 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','56','(''UA''=''F'')','ELILSLFEXPZ0','30','D','10','56',NULL,'Employee Address Line 2 Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','57','(''UA''=''F'')','ELILSLFEXPZ0','20','D','10','57',NULL,'Employee Address City Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateCode"','58','(''UA''=''F'')','ELILSLFEXPZ0','2','D','10','58',NULL,'Employee Address State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','59','(''UA''=''F'')','ELILSLFEXPZ0','9','D','10','59',NULL,'Employee Address Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','60','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','60',NULL,'Employee Address Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''SS''=''F'')','ELILSLFEXPZ0','30','D','10','61',NULL,'Employee Address County Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''SS''=''F'')','ELILSLFEXPZ0','3','D','10','62',NULL,'Employee Telephone Area Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''SS''=''F'')','ELILSLFEXPZ0','3','D','10','63',NULL,'Employee Telephone Exchange Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''SS''=''F'')','ELILSLFEXPZ0','4','D','10','64',NULL,'Employee Telephone Line Range Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','65','(''UA''=''F'')','ELILSLFEXPZ0','11','D','10','65',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSNTypeCode"','66','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','66',NULL,'Social Security Number Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGenderCode"','67','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','67',NULL,'Employee Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','68','(''UD112''=''F'')','ELILSLFEXPZ0','8','D','10','68',NULL,'Employee Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','69',NULL,'Employee Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','70',NULL,'W4 Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''SS''=''F'')','ELILSLFEXPZ0','8','D','10','71',NULL,'Spouse Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0 "','72','(''DA''=''F'')','ELILSLFEXPZ0','2','D','10','72',NULL,'Employee Dependent Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0 "','73','(''DA''=''F'')','ELILSLFEXPZ0','2','D','10','73',NULL,'Employee Dependents Under 18 Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''SS''=''F'')','ELILSLFEXPZ0','3','D','10','74',NULL,'Education Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryAmount"','75','(''UA''=''F'')','ELILSLFEXPZ0','10','D','10','75',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyWage"','76','(''UA''=''F'')','ELILSLFEXPZ0','10','D','10','76',NULL,'Hourly Wage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffectiveDate"','77','(''UD112''=''F'')','ELILSLFEXPZ0','8','D','10','77',NULL,'Salary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryType"','78','(''UA''=''F'')','ELILSLFEXPZ0','2','D','10','78',NULL,'Salary Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.0       "','79','(''DA''=''F'')','ELILSLFEXPZ0','10','D','10','79',NULL,'Bonus Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''SS''=''F'')','ELILSLFEXPZ0','10','D','10','80',NULL,'Commission Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode"','81','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','81',NULL,'Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''SS''=''F'')','ELILSLFEXPZ0','10','D','10','82',NULL,'Year to Date Wages',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''SS''=''F'')','ELILSLFEXPZ0','2','D','10','83',NULL,'W4 Withholding Allowance',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomDateElement1"','84','(''UA''=''F'')','ELILSLFEXPZ0','80','D','10','84',NULL,'Employee Custom Data Element 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomDateElement2"','85','(''UD112''=''F'')','ELILSLFEXPZ0','80','D','10','85',NULL,'Employee Custom Data Element 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomDateElement3"','86','(''UA''=''F'')','ELILSLFEXPZ0','80','D','10','86',NULL,'Employee Custom Data Element 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomDateElement4"','87','(''UD112''=''F'')','ELILSLFEXPZ0','80','D','10','87',NULL,'Employee Custom Data Element 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''SS''=''F'')','ELILSLFEXPZ0','80','D','10','88',NULL,'Employee Custom Data Element 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''SS''=''F'')','ELILSLFEXPZ0','80','D','10','89',NULL,'Employee Custom Data Element 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''SS''=''F'')','ELILSLFEXPZ0','80','D','10','90',NULL,'Employee Custom Data Element 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''SS''=''F'')','ELILSLFEXPZ0','80','D','10','91',NULL,'Employee Custom Data Element 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''SS''=''F'')','ELILSLFEXPZ0','80','D','10','92',NULL,'Employee Custom Data Element 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''SS''=''F'')','ELILSLFEXPZ0','80','D','10','93',NULL,'Employee Custom Data Element 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','94','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','94',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''SS''=''F'')','ELILSLFEXPZ0','4','D','10','95',NULL,'Service Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalDateOfHire"','96','(''UD112''=''F'')','ELILSLFEXPZ0','8','D','10','96',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','97','(''SS''=''F'')','ELILSLFEXPZ0','2','D','10','97',NULL,'Hire State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','98','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','98',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','99','(''UD112''=''F'')','ELILSLFEXPZ0','8','D','10','99',NULL,'Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.0"','100','(''SS''=''F'')','ELILSLFEXPZ0','6','D','10','100',NULL,'Hours Last 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0.0"','101','(''SS''=''F'')','ELILSLFEXPZ0','10','D','10','101',NULL,'Hours Worked Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.0"','102','(''SS''=''F'')','ELILSLFEXPZ0','9','D','10','102',NULL,'Hours Worked Per Day',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPerWeekQuantity"','103','(''UA''=''F'')','ELILSLFEXPZ0','8','D','10','103',NULL,'Days Worked per Week Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','104',NULL,'Workday Indicator - Monday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','105',NULL,'Workday Indicator - Tuesday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','106',NULL,'Workday Indicator - Wednesday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','107',NULL,'Workday Indicator - Thursday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','108',NULL,'Workday Indicator - Friday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','109',NULL,'Workday Indicator - Saturday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','110',NULL,'Workday Indicator - Sunday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''SS''=''F'')','ELILSLFEXPZ0','60','D','10','111',NULL,'Insurance Company - Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductCode1"','112','(''UA''=''F'')','ELILSLFEXPZ0','5','D','10','112',NULL,'Product 1 – Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductBenefitType1"','113','(''UA''=''F'')','ELILSLFEXPZ0','5','D','10','113',NULL,'Product 1 - Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStatus1"','114','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','114',NULL,'Product 1 - Coverage Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate1"','115','(''UD112''=''F'')','ELILSLFEXPZ0','8','D','10','115',NULL,'Product 1 - Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumContribution1"','116','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','116',NULL,'Product 1 - Employee Premium Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitLevel1"','117','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','117',NULL,'Product 1 - Benefit Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductCode2"','118','(''UA''=''F'')','ELILSLFEXPZ0','5','D','10','118',NULL,'Product 2 - Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductBenefitType2"','119','(''UA''=''F'')','ELILSLFEXPZ0','5','D','10','119',NULL,'Product 2 - Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStatus2"','120','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','120',NULL,'Product 2 - Coverage Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate2"','121','(''UD112''=''F'')','ELILSLFEXPZ0','8','D','10','121',NULL,'Product 2 - Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumContribution2"','122','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','122',NULL,'Product 2 - Employee Premium Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitLevel2"','123','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','123',NULL,'Product 2 - Benefit Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductBenefitCode3"','124','(''UA''=''F'')','ELILSLFEXPZ0','5','D','10','124',NULL,'Product 3 - Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductBenefitType3"','125','(''UA''=''F'')','ELILSLFEXPZ0','5','D','10','125',NULL,'Product 3 - Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductBenCovStatus"','126','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','126',NULL,'Product 3 - Coverage Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEffectiveDate3"','127','(''UD112''=''F'')','ELILSLFEXPZ0','8','D','10','127',NULL,'Product 3 - Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmloyeePremContrib3"','128','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','128',NULL,'Product 3 - Employee Premium Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000"','129','(''DA''=''F'')','ELILSLFEXPZ0','3','D','10','129',NULL,'Product 3 - Benefit Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','130',NULL,'Product 4 - Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','131',NULL,'Product 4 - Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','132',NULL,'Product 4 - Coverage Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''SS''=''F'')','ELILSLFEXPZ0','8','D','10','133',NULL,'Product 4 - Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumContribution4"','134','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','134',NULL,'Product 4 - Employee Premium Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitLevel4"','135','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','135',NULL,'Product 4 - Benefit Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','136',NULL,'Product 5 - Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','137',NULL,'Product 5 - Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','138',NULL,'Product 5 - Coverage Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''SS''=''F'')','ELILSLFEXPZ0','8','D','10','139',NULL,'Product 5 - Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumContribution5"','140','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','140',NULL,'Product 5 - Employee Premium Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitLevel5"','141','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','141',NULL,'Product 5 - Benefit Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','142',NULL,'Product 6 - Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','143',NULL,'Product 6 - Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','144',NULL,'Product 6 - Coverage Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''SS''=''F'')','ELILSLFEXPZ0','8','D','10','145',NULL,'Product 6 - Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumContribution6"','146','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','146',NULL,'Product 6 - Employee Premium Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitLevel6"','147','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','147',NULL,'Product 6 - Benefit Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','148',NULL,'Product 7 - Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','149',NULL,'Product 7 - Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','150',NULL,'Product 7 - Coverage Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''SS''=''F'')','ELILSLFEXPZ0','8','D','10','151',NULL,'Product 7 - Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumContribution7"','152','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','152',NULL,'Product 7 - Employee Premium Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitLevel7"','153','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','153',NULL,'Product 7 - Benefit Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','154','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','154',NULL,'Product 8 - Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''SS''=''F'')','ELILSLFEXPZ0','5','D','10','155',NULL,'Product 8 - Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','156',NULL,'Product 8 - Coverage Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''SS''=''F'')','ELILSLFEXPZ0','8','D','10','157',NULL,'Product 8 - Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumContribution8"','158','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','158',NULL,'Product 8 - Employee Premium Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitLevel8"','159','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','159',NULL,'Product 8 - Benefit Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','160','(''SS''=''F'')','ELILSLFEXPZ0','1','D','10','160',NULL,'Entitlement Tracking Duration Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','161','(''SS''=''F'')','ELILSLFEXPZ0','4','D','10','161',NULL,'Fixed Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityAmountMode"','162','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','162',NULL,'Eligibility Amount Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligAmountDuration"','163','(''UA''=''F'')','ELILSLFEXPZ0','11','D','10','163',NULL,'Eligibility Amount Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligReviewPeriodMode"','164','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','164',NULL,'Eligibility Review Period Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligReviewPeriodDuration"','165','(''UA''=''F'')','ELILSLFEXPZ0','3','D','10','165',NULL,'Eligibility Review Period Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvServiceMode"','166','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','166',NULL,'Service Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvServiceAmount"','167','(''UA''=''F'')','ELILSLFEXPZ0','12','D','10','167',NULL,'Service Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNonEligibleLocIndicator"','168','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','168',NULL,'Non-eligible Location indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','169','(''SS''=''F'')','ELILSLFEXPZ0','8','D','10','169',NULL,'Work Schedule Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursMonday"','170','(''UA''=''F'')','ELILSLFEXPZ0','9','D','10','170',NULL,'Hours per Day – Monday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursTuesday"','171','(''UA''=''F'')','ELILSLFEXPZ0','9','D','10','171',NULL,'Hours per Day – Tuesday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWed"','172','(''UA''=''F'')','ELILSLFEXPZ0','9','D','10','172',NULL,'Hours per Day – Wednesday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursThursday"','173','(''UA''=''F'')','ELILSLFEXPZ0','9','D','10','173',NULL,'Hours per Day – Thursday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursFriday"','174','(''UA''=''F'')','ELILSLFEXPZ0','9','D','10','174',NULL,'Hours per Day – Friday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursSat"','175','(''UA''=''F'')','ELILSLFEXPZ0','9','D','10','175',NULL,'Hours per Day – Saturday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursSun"','176','(''UA''=''F'')','ELILSLFEXPZ0','9','D','10','176',NULL,'Hours per Day – Sunday',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''SS''=''F'')','ELILSLFEXPZ0','8','D','10','177',NULL,'Acquisition Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLatestHireDate"','178','(''UD112''=''F'')','ELILSLFEXPZ0','8','D','10','178',NULL,'Latest Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployeeIndicator"','179','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','179',NULL,'Key Employee indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionIndicator"','180','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','180',NULL,'Union Employee indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptEmployeeIndicator"','181','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','181',NULL,'Exempt Employee indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''SS''=''F'')','ELILSLFEXPZ0','11','D','10','182',NULL,'Co-worker Spouse SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateCreated"','183','(''UD112''=''F'')','ELILSLFEXPZ0','8','D','10','183',NULL,'Date Created',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller10"','184','(''UA''=''F'')','ELILSLFEXPZ0','509','D','10','184',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordDelimiter2"','185','(''UA''=''F'')','ELILSLFEXPZ0','1','D','10','185',NULL,'Record Delimiter',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerIdTrailer"','1','(''UA''=''F'')','ELILSLFEXPZ0','9','T','90','1',NULL,'Customer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordNoTrailer"','2','(''UA''=''F'')','ELILSLFEXPZ0','7','T','90','2',NULL,'Record #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateTrailer"','3','(''UD112''=''F'')','ELILSLFEXPZ0','10','T','90','3',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberOfDetRecTrailer"','4','(''UA''=''F'')','ELILSLFEXPZ0','7','T','90','4',NULL,'Number of detailed records',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFillerTrailer"','5','(''UA''=''F'')','ELILSLFEXPZ0','2966','T','90','5',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDelimiterTrailer"','6','(''UA''=''F'')','ELILSLFEXPZ0','1','T','90','6',NULL,'Record Delimiter',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELILSLFEXP_20191025.txt',NULL,'','',NULL,NULL,NULL,NULL,'Lincoln STD LTD FMLA Export','201910259','EMPEXPORT','ONDEMAND',NULL,'ELILSLFEXP',NULL,NULL,NULL,'201910259','Oct 25 2019 12:35PM','Oct 25 2019 12:35PM','201910251',NULL,'','','201910251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELILSLFEXP_20191025.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201910259','EMPEXPORT','TEST','Oct 25 2019  3:46PM','ELILSLFEXP',NULL,NULL,NULL,'201910259','Oct 25 2019 12:35PM','Oct 25 2019 12:35PM','201910251','973','','','201910251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELILSLFEXP_20191025.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201910259','EMPEXPORT','SCHEDULED',NULL,'ELILSLFEXP',NULL,NULL,NULL,'201910259','Oct 25 2019 12:35PM','Oct 25 2019 12:35PM','201910251',NULL,'','','201910251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELILSLFEXP_20191025.txt' END WHERE expFormatCode = 'ELILSLFEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELILSLFEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELILSLFEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELILSLFEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELILSLFEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELILSLFEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELILSLFEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELILSLFEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELILSLFEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELILSLFEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELILSLFEXP','H01','dbo.U_ELILSLFEXP_Headerl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELILSLFEXP','D10','dbo.U_ELILSLFEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELILSLFEXP','T90','dbo.U_ELILSLFEXP_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_ELILSLFEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELILSLFEXP] (
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
IF OBJECT_ID('U_ELILSLFEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ELILSLFEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELILSLFEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELILSLFEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvAccountdIdNumber] varchar(6) NOT NULL,
    [drvAccountVerificationNumber] varchar(6) NOT NULL,
    [drvDisabilityCustomerId] varchar(9) NOT NULL,
    [drvDisabilitySubsidiaryCode] varchar(4) NULL,
    [drvEmployeeIdentification] char(9) NULL,
    [drvState] varchar(255) NULL,
    [drvDisabilityLocationCode] varchar(8) NOT NULL,
    [drvOccupationDesc] varchar(150) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvMiddileInitial] varchar(1) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvStateCode] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountryCode] varchar(3) NOT NULL,
    [drvSSN] varchar(13) NULL,
    [drvSSNTypeCode] varchar(1) NOT NULL,
    [drvGenderCode] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSalaryAmount] varchar(10) NULL,
    [drvHourlyWage] varchar(10) NULL,
    [drvSalaryEffectiveDate] datetime NULL,
    [drvSalaryType] varchar(2) NULL,
    [drvSalaryMode] varchar(1) NULL,
    [drvCustomDateElement1] varchar(9) NOT NULL,
    [drvCustomDateElement2] datetime NULL,
    [drvCustomDateElement3] varchar(8) NOT NULL,
    [drvCustomDateElement4] datetime NULL,
    [drvEmploymentType] varchar(1) NULL,
    [drvOriginalDateOfHire] datetime NULL,
    [drvEmploymentStatus] varchar(1) NOT NULL,
    [drvDateOfTermination] datetime NULL,
    [drvWorkPerWeekQuantity] varchar(8) NOT NULL,
    [drvProductCode1] varchar(5) NULL,
    [drvProductBenefitType1] varchar(6) NULL,
    [drvCoverageStatus1] varchar(1) NOT NULL,
    [drvEffectiveDate1] datetime NULL,
    [drvPremiumContribution1] varchar(4) NULL,
    [drvBenefitLevel1] varchar(3) NOT NULL,
    [drvProductCode2] varchar(5) NOT NULL,
    [drvProductBenefitType2] varchar(5) NOT NULL,
    [drvCoverageStatus2] varchar(1) NULL,
    [drvEffectiveDate2] datetime NULL,
    [drvPremiumContribution2] varchar(3) NOT NULL,
    [drvBenefitLevel2] varchar(3) NOT NULL,
    [drvProductBenefitCode3] varchar(5) NULL,
    [drvProductBenefitType3] varchar(5) NOT NULL,
    [drvProductBenCovStatus] varchar(1) NOT NULL,
    [drvBenEffectiveDate3] datetime NULL,
    [drvEmloyeePremContrib3] varchar(3) NOT NULL,
    [drvPremiumContribution4] varchar(3) NOT NULL,
    [drvBenefitLevel4] varchar(3) NOT NULL,
    [drvPremiumContribution5] varchar(3) NOT NULL,
    [drvBenefitLevel5] varchar(3) NOT NULL,
    [drvPremiumContribution6] varchar(3) NOT NULL,
    [drvBenefitLevel6] varchar(3) NOT NULL,
    [drvPremiumContribution7] varchar(3) NOT NULL,
    [drvBenefitLevel7] varchar(3) NOT NULL,
    [drvPremiumContribution8] varchar(3) NOT NULL,
    [drvBenefitLevel8] varchar(3) NOT NULL,
    [drvEligibilityAmountMode] varchar(1) NOT NULL,
    [drvEligAmountDuration] varchar(11) NULL,
    [drvEligAmountDurationRaw] decimal NULL,
    [drvEligReviewPeriodMode] varchar(1) NOT NULL,
    [drvEligReviewPeriodDuration] varchar(3) NOT NULL,
    [drvServiceMode] varchar(1) NOT NULL,
    [drvServiceAmount] int NULL,
    [drvNonEligibleLocIndicator] varchar(1) NOT NULL,
    [drvHoursMonday] varchar(7) NOT NULL,
    [drvHoursTuesday] varchar(7) NOT NULL,
    [drvHoursWed] varchar(7) NOT NULL,
    [drvHoursThursday] varchar(7) NOT NULL,
    [drvHoursFriday] varchar(7) NOT NULL,
    [drvHoursSat] varchar(3) NOT NULL,
    [drvHoursSun] varchar(3) NOT NULL,
    [drvLatestHireDate] datetime NULL,
    [drvKeyEmployeeIndicator] varchar(1) NOT NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvExemptEmployeeIndicator] varchar(1) NOT NULL,
    [drvDateCreated] datetime NOT NULL,
    [drvFiller10] varchar(1) NOT NULL,
    [drvRecordDelimiter2] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ELILSLFEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ELILSLFEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELILSLFEXP_File') IS NULL
CREATE TABLE [dbo].[U_ELILSLFEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ELILSLFEXP_Headerl') IS NULL
CREATE TABLE [dbo].[U_ELILSLFEXP_Headerl] (
    [drvCustomerId] varchar(9) NOT NULL,
    [drvRecordNumber] varchar(7) NOT NULL,
    [drvDate] datetime NOT NULL,
    [drvRecordLength] varchar(4) NOT NULL,
    [drvRecordDelimiter] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ELILSLFEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELILSLFEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_ELILSLFEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_ELILSLFEXP_Trailer] (
    [drvCustomerIdTrailer] varchar(9) NOT NULL,
    [drvRecordNoTrailer] varchar(7) NOT NULL,
    [drvDateTrailer] varchar(7) NULL,
    [drvNumberOfDetRecTrailer] varchar(1) NOT NULL,
    [drvFillerTrailer] varchar(1) NOT NULL,
    [drvDelimiterTrailer] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELILSLFEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: UniCarriers Americas

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 10/25/2019
Service Request Number: SR-2014-00094163

Purpose: Lincoln STD LTD FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELILSLFEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELILSLFEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELILSLFEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELILSLFEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELILSLFEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELILSLFEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELILSLFEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELILSLFEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELILSLFEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELILSLFEXP';

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
    DELETE FROM dbo.U_ELILSLFEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELILSLFEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '286,287,288,289,342,343,345,346,93,94';

    IF OBJECT_ID('U_ELILSLFEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELILSLFEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELILSLFEXP_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


        -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ELILSLFEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELILSLFEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ELILSLFEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELILSLFEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELILSLFEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELILSLFEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'D'
        ,drvAccountdIdNumber = '000000'
        ,drvAccountVerificationNumber = '000000'
        ,drvDisabilityCustomerId = '09-LF0171'
        ,drvDisabilitySubsidiaryCode = CASE  (select top  1 cmpCompanyCode from company (NOLOCK) where cmpCoid = xCoID) 
                                        WHEN 'NFCNA' THEN 'UCA0'
                                        WHEN 'CEH ' THEN 'CEH0'
                                     END 
        ,drvEmployeeIdentification = EecEmpNo
        ,drvState = (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation))
        ,drvDisabilityLocationCode = '00000000'
        ,drvOccupationDesc = eecJobTitle
        ,drvNameFirst = EepNameFirst
        ,drvNameLast = EepNameLast
        ,drvMiddileInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvStateCode = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountryCode = 'USA'
        ,drvSSN = eepSSN + '  '
        ,drvSSNTypeCode = '1'
        ,drvGenderCode = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSalaryAmount = CASE WHEN EecSalaryOrHourly = 'S' THEN CAST(eecAnnSalary as varchar(10)) Else '0.0       ' END
        ,drvHourlyWage = CASE WHEN EecSalaryOrHourly = 'S' THEN CAST(EecHourlyPayRate as varchar(10)) Else '0.0       ' END 
        ,drvSalaryEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire)
        ,drvSalaryType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SL'
                              WHEN EecSalaryOrHourly = 'H' THEN 'HR'
                         END
        ,drvSalaryMode = CASE WHEN EecSalaryOrHourly = 'S' THEN '6'
                              WHEN EecSalaryOrHourly = 'H' THEN '1'
                         END
        ,drvCustomDateElement1 = CASE WHEN EedDedCode in ('345', '287', '288' ,'289') and EedEEAmt = 10000 THEN  'CRITIL10K'
                                      WHEN EedDedCode in ('345', '287', '288' ,'289') and EedEEAmt= 20000 THEN  'CRITIL20K'
                                      ELSE ''
                                 END
        ,drvCustomDateElement2 = CASE WHEN EedDedCode in ('345', '287', '288' ,'289')  THEN ISNULL(EedBenStartDate,'') END
        ,drvCustomDateElement3 = CASE WHEN EedDedCode in ('286','346')  THEN 'ACCIDCOV' ELSE '' END
        ,drvCustomDateElement4 =  CASE WHEN EedDedCode in ('286','346')  THEN ISNULL(EedBenStartDate,'') ELSE '' END
        ,drvEmploymentType = CASE WHEN EecFullTimeOrPartTime  = 'F' THEN '1' 
                                  WHEN EecFullTimeOrPartTime  = 'P' THEN '2'
                             END
        ,drvOriginalDateOfHire = EecDateOfOriginalHire
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'T' then  'T' ELSE  'A' END
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvWorkPerWeekQuantity = '0.0     '
        ,drvProductCode1 = CASE WHEN EedDedCode in ('94','342') THEN 'STD  ' END
        ,drvProductBenefitType1 = CASE  (select top  1 cmpCompanyCode from company (NOLOCK) where cmpCoid = xCoID) 
                                        WHEN 'NFCNA' THEN 'STD04 '
                                        WHEN 'CEH ' THEN 'STD02 '
                                     END 
        ,drvCoverageStatus1 = CASE WHEN EedDedCode in ('94','342')  and EedBenStatus = 'T' THEN 'T' 
                                   WHEN EedDedCode in ('94','342')  and EedBenStatus = 'A' THEN 'A'
                                   Else ' '
                                END
        ,drvEffectiveDate1 = CASE WHEN EedDedCode in ('94','342') THEN EedBenStartDate END
        ,drvPremiumContribution1 = CASE  (select top  1 cmpCompanyCode from company (NOLOCK) where cmpCoid = xCoID) 
                                        WHEN 'NFCNA' THEN '000 '
                                        WHEN 'CEH ' THEN '100'
                                     END
        ,drvBenefitLevel1 = CASE  (select top  1 cmpCompanyCode from company (NOLOCK) where cmpCoid = xCoID) 
                                        WHEN 'NFCNA' THEN '070'
                                        WHEN 'CEH ' THEN '060'
                                        ELSE '0  '
                                     END
        ,drvProductCode2 = CASE WHEN EedDedCode in ('93','343') THEN 'LTD' ELSE '     ' END
        ,drvProductBenefitType2 = CASE WHEN EedDedCode in ('93','343') THEN 'LTD01' ELSE '     ' END
        ,drvCoverageStatus2 = CASE WHEN EedDedCode in ('93','343') and EedBenStatus = 'T' THEN 'T'  
                                   WHEN EedDedCode in ('93','343') and EedBenStatus = 'A' THEN 'A'  
                                  END
        ,drvEffectiveDate2 =  CASE WHEN EedDedCode in ('93','343') THEN EedBenStartDate  END
        ,drvPremiumContribution2 = CASE WHEN EedDedCode in ('93','343') THEN '000' ELSe '0'  END
        ,drvBenefitLevel2 = CASE WHEN EedDedCode in ('93','343') THEN '060' ELSe '0'  END
        ,drvProductBenefitCode3 = CASE WHEN EecEEType = 'REG' THEN  'LEAVE' END
        ,drvProductBenefitType3 = 'FMLA '
        ,drvProductBenCovStatus = 'A'
        ,drvBenEffectiveDate3 = EecDateOfOriginalHire
        ,drvEmloyeePremContrib3 = '000'
        ,drvPremiumContribution4 = '0  '
        ,drvBenefitLevel4 = '0  '
        ,drvPremiumContribution5 = '0  '
        ,drvBenefitLevel5 = '0  '
        ,drvPremiumContribution6 = '0  '
        ,drvBenefitLevel6 = '0  '
        ,drvPremiumContribution7 = '0  '
        ,drvBenefitLevel7 = '0  '
        ,drvPremiumContribution8 = '0  '
        ,drvBenefitLevel8 = '0  '
        ,drvEligibilityAmountMode = 'H'
        ,drvEligAmountDuration = CAST(PehCurHrsYTD as varchar(11))
        ,drvEligAmountDurationRaw = PehCurHrsYTD
        ,drvEligReviewPeriodMode = 'M'
        ,drvEligReviewPeriodDuration = '012'
        ,drvServiceMode = 'M'
        ,drvServiceAmount = DATEDIFF(month,GETDATE(),EecDateOfSeniority) 
        ,drvNonEligibleLocIndicator = ' '
        ,drvHoursMonday = '8      '
        ,drvHoursTuesday = '8      '
        ,drvHoursWed = '8      '
        ,drvHoursThursday = '8      '
        ,drvHoursFriday = '8      '
        ,drvHoursSat = '0.0'
        ,drvHoursSun = '0.0'
        ,drvLatestHireDate = EecDateOfLastHire
        ,drvKeyEmployeeIndicator = 'Y'
        ,drvUnionIndicator = ''
        ,drvExemptEmployeeIndicator = ''
        ,drvDateCreated = GETDATE()
        ,drvFiller10 = ''
        ,drvRecordDelimiter2 = ''
    INTO dbo.U_ELILSLFEXP_drvTbl
    FROM dbo.U_ELILSLFEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_ELILSLFEXP_PEarHist
        on PehEEID = xEEID;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELILSLFEXP_Headerl','U') IS NOT NULL
        DROP TABLE dbo.U_ELILSLFEXP_Headerl;
    SELECT DISTINCT
         drvCustomerId = '09-LF0171'
        ,drvRecordNumber = '0000000'
        ,drvDate = GETDATE()
        ,drvRecordLength = '3000'
        ,drvRecordDelimiter = ''
    INTO dbo.U_ELILSLFEXP_Headerl
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELILSLFEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ELILSLFEXP_Trailer;
    SELECT DISTINCT
         drvCustomerIdTrailer = '09-LF0171'
        ,drvRecordNoTrailer = '9999999'
        ,drvDateTrailer = CAST((Select count(*) from dbo.U_ELILSLFEXP_drvTbl) as varchar(7))
        ,drvNumberOfDetRecTrailer = ''
        ,drvFillerTrailer = ''
        ,drvDelimiterTrailer = ''
    INTO dbo.U_ELILSLFEXP_Trailer
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
ALTER VIEW dbo.dsi_vwELILSLFEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELILSLFEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELILSLFEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201910181'
       ,expStartPerControl     = '201910181'
       ,expLastEndPerControl   = '201910259'
       ,expEndPerControl       = '201910259'
WHERE expFormatCode = 'ELILSLFEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELILSLFEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELILSLFEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort