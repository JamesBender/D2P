SQLStmt
SET NOCOUNT ON;
IF OBJECT_ID('U_EPRUDELIXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EPRUDELIXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EPRUDELIXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEPRUDELIXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRUDELIXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRUDELIXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDELIXP];
GO
IF OBJECT_ID('U_EPRUDELIXP_Headerl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_Headerl];
GO
IF OBJECT_ID('U_EPRUDELIXP_File') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_File];
GO
IF OBJECT_ID('U_EPRUDELIXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_EEList];
GO
IF OBJECT_ID('U_EPRUDELIXP_drvTrailer') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_drvTrailer];
GO
IF OBJECT_ID('U_EPRUDELIXP_drvEmpTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_drvEmpTbl];
GO
IF OBJECT_ID('U_EPRUDELIXP_drvDepTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_drvDepTbl];
GO
IF OBJECT_ID('U_EPRUDELIXP_drvCovTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_drvCovTbl];
GO
IF OBJECT_ID('U_EPRUDELIXP_drvAstTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_drvAstTbl];
GO
IF OBJECT_ID('U_EPRUDELIXP_drvAbsTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_drvAbsTbl];
GO
IF OBJECT_ID('U_EPRUDELIXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_DedList];
GO
IF OBJECT_ID('U_EPRUDELIXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_AuditFields];
GO
IF OBJECT_ID('U_EPRUDELIXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EPRUDELIXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPRUDELIXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EPRUDELIXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EPRUDELIXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EPRUDELIXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EPRUDELIXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EPRUDELIXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPRUDELIXP','Prudential Benefits Eligibility','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EPRUDELIXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''T~'')','EPRUDELIXPZ0','3','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionGUID"','2','(''UA''=''T~'')','EPRUDELIXPZ0','32','H','01','2',NULL,'Transmission GUID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDateTime"','3','(''UA''=''T~'')','EPRUDELIXPZ0','14','H','01','3',NULL,'File Creation Date Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvControlNumber"','4','(''UA''=''T~'')','EPRUDELIXPZ0','10','H','01','4',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileTypeVersion"','5','(''UA''=''T~'')','EPRUDELIXPZ0','6','H','01','5',NULL,'File Type Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSenderName"','6','(''UA''=''T~'')','EPRUDELIXPZ0','50','H','01','6',NULL,'Sender Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSenderPlatformName"','7','(''UA''=''T~'')','EPRUDELIXPZ0','50','H','01','7',NULL,'Sender Platform Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTestProductionCode"','8','(''UA''=''T~'')','EPRUDELIXPZ0','14','H','01','8',NULL,'Test Production Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransmissionTypeCode"','9','(''UA''=''T~'')','EPRUDELIXPZ0','32','H','01','9',NULL,'Transmission Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActivityDateTime"','10','(''UA''=''T~'')','EPRUDELIXPZ0','14','H','01','10',NULL,'Activity Start Date Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActivityEndDateTime"','11','(''UA''=''T'')','EPRUDELIXPZ0','14','H','01','11',NULL,'Activity End Date Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AST"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"59904"','2','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','10','2',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTAssociateId"','3','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','10','3',NULL,'Associate Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTSSNumber"','4','(''UA''=''T~'')','EPRUDELIXPZ0','9','D','10','4',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTGendeCode"','5','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','10','5',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTDateOfBirth"','6','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','10','6',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTDateofDeath"','7','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','10','7',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTSmokerStatus"','8','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','10','8',NULL,'Smoker Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTMaritalStatus"','9','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','10','9',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','10','10',NULL,'Prefix Title Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTFirstName"','11','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','10','11',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTMiddleName"','12','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','10','12',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTLastName"','13','(''UA''=''T~'')','EPRUDELIXPZ0','80','D','10','13',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTSuffix"','14','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','10','14',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressTypeCode"','15','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','10','15',NULL,'Address Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','16','(''UA''=''T~'')','EPRUDELIXPZ0','64','D','10','16',NULL,'Address Line 1 Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','17','(''UA''=''T~'')','EPRUDELIXPZ0','64','D','10','17',NULL,'Address Line 2 Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','18',NULL,'Address Line 3 Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','19','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','10','19',NULL,'City Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateProvinceCode"','20','(''UA''=''T~'')','EPRUDELIXPZ0','2','D','10','20',NULL,'State Province Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','21','(''UA''=''T~'')','EPRUDELIXPZ0','12','D','10','21',NULL,'Postal Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','22','(''UA''=''T~'')','EPRUDELIXPZ0','35','D','10','22',NULL,'Country Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','10','23',NULL,'Address Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','24',NULL,'Address Line 1 Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','25',NULL,'Address Line 2 Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','26',NULL,'Address Line 3 Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','10','27',NULL,'City Name 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T~'')','EPRUDELIXPZ0','2','D','10','28',NULL,'State Province Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','10','29',NULL,'Postal Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T~'')','EPRUDELIXPZ0','35','D','10','30',NULL,'Country Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','10','31',NULL,'Address Type Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','32',NULL,'Address Line 1 Text 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','33',NULL,'Address Line 2 Text 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','34',NULL,'Address Line 3 Text 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','10','35',NULL,'City Name 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T~'')','EPRUDELIXPZ0','2','D','10','36',NULL,'State Province Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','10','37',NULL,'Postal Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T~'')','EPRUDELIXPZ0','35','D','10','38',NULL,'Country Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneTypeCode1"','39','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','10','39',NULL,'Telephone Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber1"','40','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','10','40',NULL,'Telephone Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','10','41',NULL,'Telephone Number Extension 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneTypeCode2"','42','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','10','42',NULL,'Telephone Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber2"','43','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','10','43',NULL,'Telephone Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','10','44',NULL,'Telephone Number Extension 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','10','45',NULL,'Telephone  Type Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T~'')','EPRUDELIXPZ0','20','D','10','46',NULL,'Telephone Number 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','10','47',NULL,'Telephone Number Extension 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailTypeCode1"','48','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','10','48',NULL,'Email Address Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail1"','49','(''UA''=''T~'')','EPRUDELIXPZ0','350','D','10','49',NULL,'Email Address Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','10','50',NULL,'Email Address Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T'')','EPRUDELIXPZ0','350','D','10','51',NULL,'Email Address Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMP"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','15','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"59904"','2','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','15','2',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAssociateId"','3','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','15','3',NULL,'Associate Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIdentifier"','4','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','15','4',NULL,'Employee Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','5','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','5',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofLastHire"','6','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','6',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfRetirement"','7','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','7',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','8','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','8',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonCode"','9','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','15','9',NULL,'Employment Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','15','10',NULL,'Adjusted Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','15','11',NULL,'Last Active Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatusCode"','12','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','12',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','15','13',NULL,'Employment Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','15','14',NULL,'Employment Status Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','15','15',NULL,'Job Title Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','15','16',NULL,'Occupation Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','17',NULL,'OSHA Job Classification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','18',NULL,'Occupation Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','19',NULL,'Work Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklySchedHours"','20','(''UA''=''T~'')','EPRUDELIXPZ0','5','D','15','20',NULL,'Weekly Scheduled Hours Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDailyHoursWorked"','21','(''UA''=''T~'')','EPRUDELIXPZ0','5','D','15','21',NULL,'Daily Work Hours Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','22',NULL,'Hourly Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningTypeCode1"','23','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','23',NULL,'Earnings Type  Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningEffectiveDate1"','24','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','24',NULL,'Earnings Effective  Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmount1"','25','(''UA''=''T~'')','EPRUDELIXPZ0','17','D','15','25',NULL,'Earnings  Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningFrequencyCode1"','26','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','26',NULL,'Earnings Frequency Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningTypeCode2"','27','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','27',NULL,'Earnings Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningEffectiveDate2"','28','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','28',NULL,'Earnings Effective Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmount2"','29','(''UA''=''T~'')','EPRUDELIXPZ0','17','D','15','29',NULL,'Earnings Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningFrequencyCode2"','30','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','30',NULL,'Earnings Frequency  Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','15','31',NULL,'W4 Filing Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T~'')','EPRUDELIXPZ0','4','D','15','32',NULL,'W4 Exemptions Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T~'')','EPRUDELIXPZ0','17','D','15','33',NULL,'W4 Additional Withholding Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T~'')','EPRUDELIXPZ0','2','D','15','34',NULL,'W4 Withholding State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','15','35',NULL,'W4 Work Location Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','36','(''UA''=''T~'')','EPRUDELIXPZ0','2','D','15','36',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionIndicator"','37','(''UA''=''T~'')','EPRUDELIXPZ0','1','D','15','37',NULL,'Union Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','38',NULL,'Local Bargaining Unit Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberGroupCode"','39','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','15','39',NULL,'Member Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupCode"','40','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','15','40',NULL,'Bill Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFreqCode"','41','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','41',NULL,'Payroll Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','42',NULL,'District Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"001"','43','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','15','43',NULL,'Employment Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','15','44',NULL,'Regional Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T~'')','EPRUDELIXPZ0','20','D','15','45',NULL,'Employer Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T'')','EPRUDELIXPZ0','80','D','15','46',NULL,'Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ABS"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"59904"','2','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','20','2',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAbsEmpNo"','3','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','20','3',NULL,'Associate ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','4',NULL,'YeartoDateEarnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','20','5',NULL,'EarnigsAsofDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','6',NULL,'State Leave Earnings Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','7',NULL,'State Leave Earnings Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','8',NULL,'Company Leave Earnings Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','9',NULL,'Company Leave Earnings Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','10',NULL,'AsofHoursWorkedinLast12Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T~'')','EPRUDELIXPZ0','2','D','20','11',NULL,'Withholding State 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T~'')','EPRUDELIXPZ0','2','D','20','12',NULL,'Withholding State 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','13',NULL,'Deduction 1 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','14',NULL,'Deduction 1 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','15',NULL,'Deduction 1 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','16',NULL,'Deduction 2 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','17',NULL,'Deduction 2 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','18',NULL,'Deduction 2 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','19',NULL,'Deduction 3 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','20',NULL,'Deduction 3 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','21',NULL,'Deduction 3 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','22',NULL,'Deduction 4 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','23',NULL,'Deduction 4 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','24',NULL,'Deduction 4 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','25',NULL,'Deduction 5 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','26',NULL,'Deduction 5 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','27',NULL,'Deduction 5 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','28',NULL,'Deduction 6 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','29',NULL,'Deduction 6 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','30',NULL,'Deduction 6 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','31',NULL,'Deduction 7 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','32',NULL,'Deduction 7 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','33',NULL,'Deduction 7 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','34',NULL,'Deduction 8 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','35',NULL,'Deduction 8 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','36',NULL,'Deduction 8 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','37',NULL,'Deduction 9 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','38',NULL,'Deduction 9 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','39',NULL,'Deduction 9 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','40',NULL,'Deduction 10 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','20','41',NULL,'Deduction 10 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','42',NULL,'Deduction 10 Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportingCode1"','43','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','20','43',NULL,'Reporting Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','44',NULL,'Reporting Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','45',NULL,'Reporting Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','46',NULL,'Reporting Code 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','47',NULL,'Reporting Code 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','48',NULL,'Reporting Code 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','49',NULL,'Reporting Code 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','50',NULL,'Reporting Code 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','51',NULL,'Reporting Code 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','52',NULL,'Reporting Code 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','53',NULL,'Reporting Code 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','54',NULL,'Reporting Code 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','55',NULL,'Reporting Code 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','56',NULL,'Reporting Code 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','57',NULL,'Reporting Code 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','58',NULL,'Reporting Code 16',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','59',NULL,'Reporting Code 17',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','60',NULL,'Reporting Code 18',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','61',NULL,'Reporting Code 19',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','62',NULL,'Reporting Code 20',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR REPRESENTATIVE"','63','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','63',NULL,'Contact 1 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepNameLast"','64','(''UA''=''T~'')','EPRUDELIXPZ0','40','D','20','64',NULL,'Contact 1 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''T~'')','EPRUDELIXPZ0','40','D','20','65',NULL,'Contact 1 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','20','66',NULL,'Contact 1 Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','20','67',NULL,'Contact 1 Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContactEmail"','68','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','20','68',NULL,'Contact 1 Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','20','69',NULL,'Contact 1 ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''T~'')','EPRUDELIXPZ0','9','D','20','70',NULL,'Contact 1 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','71',NULL,'Contact 2 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''T~'')','EPRUDELIXPZ0','40','D','20','72',NULL,'Contact 2 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''T~'')','EPRUDELIXPZ0','40','D','20','73',NULL,'Contact 2 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','20','74',NULL,'Contact 2 Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','20','75',NULL,'Contact 2 Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','76',NULL,'Contact 2 Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','20','77',NULL,'Contact 2 ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''T~'')','EPRUDELIXPZ0','9','D','20','78',NULL,'Contact 2 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','79',NULL,'Contact 3 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''T~'')','EPRUDELIXPZ0','40','D','20','80',NULL,'Contact 3 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''T~'')','EPRUDELIXPZ0','40','D','20','81',NULL,'Contact 3 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','20','82',NULL,'Contact 3 Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','20','83',NULL,'Contact 3 Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','84',NULL,'Contact 3 Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','20','85',NULL,'Contact 3 ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''T~'')','EPRUDELIXPZ0','9','D','20','86',NULL,'Contact 3 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''T~'')','EPRUDELIXPZ0','5','D','20','87',NULL,'Contact 4 Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''T~'')','EPRUDELIXPZ0','40','D','20','88',NULL,'Contact 4 Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''T~'')','EPRUDELIXPZ0','40','D','20','89',NULL,'Contact 4 First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','20','90',NULL,'Contact 4 Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','20','91',NULL,'Contact 4 Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','20','92',NULL,'Contact 4 Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','20','93',NULL,'Contact 4 ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''T~'')','EPRUDELIXPZ0','9','D','20','94',NULL,'Contact 4 SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','95','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','20','95',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentSector"','96','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','20','96',NULL,'Employment Sector',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFMLABranchCode"','97','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','20','97',NULL,'FMLA Branch Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFMLAWorkLocationCode"','98','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','20','98',NULL,'FMLA Work Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEIndicator"','99','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','20','99',NULL,'Key EE Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStandardWorkSchedule"','100','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','20','100',NULL,'Standard Work Schedule',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkLast12Months"','101','(''UA''=''T~'')','EPRUDELIXPZ0','6','D','20','101',NULL,'HoursWorkedinLast12Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','102',NULL,'HoursWorkedSinceLastFile',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','103',NULL,'OtherHoursWorkedinLast12Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAsOfDateHoursLast12Months"','104','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','20','104',NULL,'AsofDateOtherHoursWorkedinLast12Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','105',NULL,'Share Leave Relationship Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','106','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','106',NULL,'Shared Leave Relationship SSN 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','107','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','107',NULL,'Share Leave Relationship First Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','108',NULL,'Share Leave Relationship Last Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','109',NULL,'Shared Leave Relationship EEID 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','110',NULL,'Share Leave Relationship Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','111',NULL,'Shared Leave Relationship SSN 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','112',NULL,'Share Leave Relationship First Name 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','113',NULL,'Share Leave Relationship Last Name 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','114',NULL,'Shared Leave Relationship EEID 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','115',NULL,'Share Leave Relationship Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','116',NULL,'Shared Leave Relationship SSN 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','117',NULL,'Share Leave Relationship First Name 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','118',NULL,'Share Leave Relationship LastName 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','119','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','20','119',NULL,'Shared Leave Relationship EEID 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','120','(''DA''=''T'')','EPRUDELIXPZ0','255','D','20','120',NULL,'Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COV"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','25','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"59904"','2','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','25','2',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovEmpNo"','3','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','25','3',NULL,'Associate Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovProductCode"','4','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','25','4',NULL,'Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovProductTier"','5','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','25','5',NULL,'Coverage Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovProdPlanCode"','6','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','25','6',NULL,'Product Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovBuyUpIndc"','7','(''UA''=''T~'')','EPRUDELIXPZ0','1','D','25','7',NULL,'Coverage Buy Up Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovProdCovAmt"','8','(''UA''=''T~'')','EPRUDELIXPZ0','17','D','25','8',NULL,'Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovEffectiveDate"','9','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','25','9',NULL,'Coverage  Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovEndDate"','10','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','25','10',NULL,'Coverage  End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovStatusCode"','11','(''UD112''=''T~'')','EPRUDELIXPZ0','25','D','25','11',NULL,'Coverage Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovStatusEffectiveDate"','12','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','25','12',NULL,'Coverage Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovStatusReasonCode"','13','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','25','13',NULL,'Coverage Status Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','25','14',NULL,'Coverage Termination Reduction Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T~'')','EPRUDELIXPZ0','17','D','25','15',NULL,'Coverage Termination Reduction Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','25','16',NULL,'Flat Benefit Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00001"','17','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','25','17',NULL,'Claim Branch Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','25','18',NULL,'EOB Correspondence Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','19','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','25','19',NULL,'Assignment Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','25','20',NULL,'Original LTD Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','25','21',NULL,'Partner Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','25','22',NULL,'Partner Short Benefit Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','25','23',NULL,'Client Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T~'')','EPRUDELIXPZ0','2','D','25','24',NULL,'Benefit Option Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','25','25',NULL,'Coverage Increase Within 2 years Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','25','26',NULL,'Issuance Age',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryBasis"','27','(''UA''=''T'')','EPRUDELIXPZ0','25','D','25','27',NULL,'Voluntary Basis',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"59904"','2','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','30','2',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEmpNo"','3','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','30','3',NULL,'Associate Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConSSN"','4','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','30','4',NULL,'Dependent Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipTypeCode"','5','(''UA''=''T~'')','EPRUDELIXPZ0','35','D','30','5',NULL,'Relationship Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEPSSN"','6','(''UA''=''T~'')','EPRUDELIXPZ0','9','D','30','6',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConGender"','7','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','30','7',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateConBirthDate"','8','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','30','8',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateConDeathDate"','9','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','30','9',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConDrvStatusCode"','10','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','30','10',NULL,'Smoker Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConMaritalStatusCode"','11','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','30','11',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','30','12',NULL,'Prefix Title Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName"','13','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','30','13',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleName"','14','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','30','14',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName"','15','(''UA''=''T~'')','EPRUDELIXPZ0','80','D','30','15',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepSuffixName"','16','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','30','16',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepAddressTypeCode"','17','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','30','17',NULL,'Address Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepAddressLine1"','18','(''UA''=''T~'')','EPRUDELIXPZ0','64','D','30','18',NULL,'Address Line 1 Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepAddressLine2"','19','(''UA''=''T~'')','EPRUDELIXPZ0','64','D','30','19',NULL,'Address Line 2 Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','30','20',NULL,'Address Line 3 Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCity"','21','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','30','21',NULL,'City Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepState"','22','(''UA''=''T~'')','EPRUDELIXPZ0','2','D','30','22',NULL,'State Province Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepZipCode"','23','(''UA''=''T~'')','EPRUDELIXPZ0','12','D','30','23',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USA"','24','(''DA''=''T~'')','EPRUDELIXPZ0','35','D','30','24',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepTelephoneType1"','25','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','30','25',NULL,'Telephone Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepTelephoneNumber1"','26','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','30','26',NULL,'Telephone Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','27','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','30','27',NULL,'Telephone Number Extension 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','28','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','30','28',NULL,'Telephone Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T~'')','EPRUDELIXPZ0','20','D','30','29',NULL,'Telephone Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','30','30',NULL,'Telephone Number Extension 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','30','31',NULL,'Telephone  Type Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T~'')','EPRUDELIXPZ0','20','D','30','32',NULL,'Telephone Number 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','30','33',NULL,'Telephone Number Extension 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEmailAddressType1"','34','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','30','34',NULL,'Email Address Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEmailAddress1"','35','(''UA''=''T~'')','EPRUDELIXPZ0','350','D','30','35',NULL,'Email Address Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','30','36',NULL,'Email Address Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T~'')','EPRUDELIXPZ0','350','D','30','37',NULL,'Email Address Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','30','38',NULL,'Dependent Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','30','39',NULL,'Dependent Delete Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','30','40',NULL,'Student Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','30','41',NULL,'Incapacitated Dependent Clause Certification Indic',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','30','42',NULL,'Incapacitated Dependent Clause Certification Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRL"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDateTrailer"','2','(''UA''=''T~'')','EPRUDELIXPZ0','8','T','90','2',NULL,'File Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''T~'')','EPRUDELIXPZ0','32','T','90','3',NULL,'Audit ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','4','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','4',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTCount"','5','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','5',NULL,'Associate Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPRecordCount"','6','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','6',NULL,'Employment Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','7','(''DA''=''T~'')','EPRUDELIXPZ0','10','T','90','7',NULL,'Employment Salary Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','8','(''DA''=''T~'')','EPRUDELIXPZ0','10','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvABSCount"','9','(''UA''=''T~'')','EPRUDELIXPZ0','10','T','90','9',NULL,'Absence Related Employment Information Record Quan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','10','(''DA''=''T~'')','EPRUDELIXPZ0','9','T','90','10',NULL,'Employment Deduction Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','11','(''DA''=''T~'')','EPRUDELIXPZ0','9','T','90','11',NULL,'Preference Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','12','(''DA''=''T~'')','EPRUDELIXPZ0','9','T','90','12',NULL,'Event Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOVCount"','13','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','13',NULL,'Coverage Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','14','(''DA''=''T~'')','EPRUDELIXPZ0','10','T','90','14',NULL,'Coverage Deduction Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','15','(''DA''=''T~'')','EPRUDELIXPZ0','10','T','90','15',NULL,'Payroll Deduction Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEPCount"','16','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','16',NULL,'Dependent Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','17','(''DA''=''T~'')','EPRUDELIXPZ0','9','T','90','17',NULL,'Beneficiary Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','18','(''DA''=''T~'')','EPRUDELIXPZ0','9','T','90','18',NULL,'Contact Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','19','(''DA''=''T~'')','EPRUDELIXPZ0','9','T','90','19',NULL,'EOI Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','20','(''DA''=''T~'')','EPRUDELIXPZ0','9','T','90','20',NULL,'Custom Characteristics Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalBenAmt"','21','(''UA''=''T'')','EPRUDELIXPZ0','17','T','90','21',NULL,'Total Benefit Amount',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPRUDELIXP_20191223.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Benefits Eligibilit','201910239','EMPEXPORT','ONDEMAND',NULL,'EPRUDELIXP',NULL,NULL,NULL,'201910239','Oct 23 2019 12:38PM','Oct 23 2019 12:38PM','201910231',NULL,'','','201910231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPRUDELIXP_20191223.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201910239','EMPEXPORT','SCHEDULED',NULL,'EPRUDELIXP',NULL,NULL,NULL,'201910239','Oct 23 2019 12:38PM','Oct 23 2019 12:38PM','201910231',NULL,'','','201910231',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPRUDELIXP_20191223.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202001319','EMPEXPORT','OEACTIVE','Dec 19 2019  9:02AM','EPRUDELIXP',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','2968','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiPEO1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPRUDELIXP_20191223.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202001319','EMPEXPORT','TEST','Dec 20 2019  3:37PM','EPRUDELIXP',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','201911011','2736','','','201911011',dbo.fn_GetTimedKey(),NULL,'us3lKiPEO1006',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPRUDELIXP_20191223.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202001319','EMPEXPORT','OEPASSIVE','Dec 23 2019  5:37PM','EPRUDELIXP',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','4733','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiPEO1006',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EPRUDELIXP_20191223.txt' END WHERE expFormatCode = 'EPRUDELIXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EPRUDELIXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EPRUDELIXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EPRUDELIXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','H01','dbo.U_EPRUDELIXP_Headerl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','D10','dbo.U_EPRUDELIXP_drvAstTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','D15','dbo.U_EPRUDELIXP_drvEmpTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','D20','dbo.U_EPRUDELIXP_drvAbsTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','D25','dbo.U_EPRUDELIXP_drvCovTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','D30','dbo.U_EPRUDELIXP_drvDepTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','T90','dbo.U_EPRUDELIXP_drvTrailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EPRUDELIXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPRUDELIXP] (
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
IF OBJECT_ID('U_EPRUDELIXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EPRUDELIXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EPRUDELIXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvAbsTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvAbsTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvAbsEmpNo] char(9) NULL,
    [drvReportingCode1] char(6) NULL,
    [drvHRRepNameLast] varchar(6) NOT NULL,
    [drvContactEmail] varchar(31) NOT NULL,
    [drvEmploymentType] varchar(5) NOT NULL,
    [drvEmploymentSector] varchar(5) NOT NULL,
    [drvFMLABranchCode] varchar(5) NOT NULL,
    [drvFMLAWorkLocationCode] varchar(10) NOT NULL,
    [drvEEIndicator] varchar(1) NOT NULL,
    [drvStandardWorkSchedule] varchar(1) NOT NULL,
    [drvHoursWorkLast12Months] varchar(4) NOT NULL,
    [drvAsOfDateHoursLast12Months] datetime NOT NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvAstTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvAstTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvASTAssociateId] char(9) NULL,
    [drvASTSSNumber] char(11) NULL,
    [drvASTGendeCode] varchar(7) NOT NULL,
    [drvASTDateOfBirth] datetime NULL,
    [drvASTDateofDeath] datetime NULL,
    [drvASTSmokerStatus] varchar(9) NOT NULL,
    [drvASTMaritalStatus] varchar(8) NOT NULL,
    [drvASTFirstName] varchar(100) NULL,
    [drvASTMiddleName] varchar(50) NULL,
    [drvASTLastName] varchar(100) NULL,
    [drvASTSuffix] varchar(30) NULL,
    [drvAddressTypeCode] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] char(1) NULL,
    [drvStateProvinceCode] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountryCode] varchar(3) NOT NULL,
    [drvPhoneTypeCode1] varchar(4) NOT NULL,
    [drvPhoneNumber1] varchar(50) NULL,
    [drvPhoneTypeCode2] varchar(6) NULL,
    [drvPhoneNumber2] varchar(50) NULL,
    [drvEmailTypeCode1] varchar(8) NULL,
    [drvEmail1] varchar(50) NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvCovTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvCovTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCovEmpNo] char(9) NULL,
    [drvCovProductCode] varchar(4) NOT NULL,
    [drvCovProductTier] varchar(2) NULL,
    [drvCovProdPlanCode] varchar(4) NULL,
    [drvCovBuyUpIndc] varchar(1) NOT NULL,
    [drvCovProdCovAmt] varchar(12) NULL,
    [drvCovProdCovAmtRaw] money NOT NULL,
    [drvCovEffectiveDate] datetime NULL,
    [drvCovEndDate] datetime NULL,
    [drvCovStatusCode] varchar(10) NULL,
    [drvCovStatusEffectiveDate] varchar(1) NOT NULL,
    [drvCovStatusReasonCode] varchar(1) NOT NULL,
    [drvVoluntaryBasis] varchar(9) NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvDepTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvDepTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepEmpNo] char(9) NULL,
    [drvConSSN] char(11) NULL,
    [drvDepRelationshipTypeCode] varchar(16) NULL,
    [drvDEPSSN] char(11) NULL,
    [drvConGender] varchar(7) NOT NULL,
    [drvDateConBirthDate] datetime NULL,
    [drvDateConDeathDate] datetime NULL,
    [drvConDrvStatusCode] varchar(10) NOT NULL,
    [drvConMaritalStatusCode] varchar(8) NOT NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepMiddleName] varchar(50) NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepSuffixName] varchar(30) NULL,
    [drvDepAddressTypeCode] varchar(4) NOT NULL,
    [drvDepAddressLine1] varchar(255) NULL,
    [drvDepAddressLine2] varchar(255) NULL,
    [drvDepCity] varchar(255) NULL,
    [drvDepState] varchar(255) NULL,
    [drvDepZipCode] varchar(50) NULL,
    [drvDepTelephoneType1] varchar(4) NOT NULL,
    [drvDepTelephoneNumber1] varchar(50) NULL,
    [drvDepEmailAddressType1] varchar(8) NULL,
    [drvDepEmailAddress1] varchar(50) NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvEmpTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvEmpTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(13) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpAssociateId] char(9) NULL,
    [drvEmpIdentifier] char(9) NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateofLastHire] datetime NULL,
    [drvDateOfRetirement] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvTerminationReasonCode] varchar(10) NULL,
    [drvEmpStatusCode] varchar(16) NULL,
    [drvWeeklySchedHours] varchar(12) NULL,
    [drvDailyHoursWorked] varchar(12) NULL,
    [drvEarningTypeCode1] varchar(8) NOT NULL,
    [drvEarningEffectiveDate1] datetime NULL,
    [drvEarningAmount1] varchar(12) NULL,
    [drvEarningFrequencyCode1] varchar(6) NOT NULL,
    [drvEarningTypeCode2] varchar(1) NOT NULL,
    [drvEarningEffectiveDate2] varchar(1) NOT NULL,
    [drvEarningAmount2] varchar(1) NOT NULL,
    [drvEarningFrequencyCode2] varchar(1) NOT NULL,
    [drvWorkState] varchar(255) NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvMemberGroupCode] varchar(3) NOT NULL,
    [drvBillGroupCode] varchar(9) NOT NULL,
    [drvPayrollFreqCode] varchar(10) NOT NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvTrailer') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvTrailer] (
    [drvFileCreationDateTrailer] nvarchar(30) NULL,
    [drvRecordCount] varchar(12) NULL,
    [drvASTCount] varchar(12) NULL,
    [drvEMPRecordCount] varchar(12) NULL,
    [drvABSCount] varchar(12) NULL,
    [drvCOVCount] varchar(12) NULL,
    [drvDEPCount] varchar(12) NULL,
    [drvTotalBenAmt] varchar(12) NULL
);
IF OBJECT_ID('U_EPRUDELIXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EPRUDELIXP_File') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EPRUDELIXP_Headerl') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_Headerl] (
    [drvRecordType] varchar(3) NOT NULL,
    [drvTransmissionGUID] varchar(1) NOT NULL,
    [drvFileCreationDateTime] varchar(14) NULL,
    [drvControlNumber] varchar(5) NOT NULL,
    [drvFileTypeVersion] varchar(3) NOT NULL,
    [drvSenderName] varchar(19) NOT NULL,
    [drvSenderPlatformName] varchar(1) NOT NULL,
    [drvTestProductionCode] varchar(10) NOT NULL,
    [drvTransmissionTypeCode] varchar(1) NOT NULL,
    [drvActivityDateTime] varchar(14) NULL,
    [drvActivityEndDateTime] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDELIXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: People Incorporated
 
Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 10/23/2019
Service Request Number: SR-2019-00250239
 
Purpose: Prudential Benefits Eligibility
 
Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX
 
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUDELIXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUDELIXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUDELIXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRUDELIXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUDELIXP' ORDER BY RunID DESC;
 
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDELIXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDELIXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDELIXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDELIXP', 'TEST';
 
EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRUDELIXP';
 
EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRUDELIXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@FileMinCovDate       DATETIME
            ,@FileDateStart as VARCHAR(14)
            ,@FileDateStartSevenDays as VARCHAR(14);
 
 
    -- Set FormatCode
    SELECT @FormatCode = 'EPRUDELIXP';
    Select @FileDateStartSevenDays = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar, DATEADD(DAY,-7,GETDATE()), 120),'-',''),':',''),' ','');
    Select @FileDateStart = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar, GETDATE(), 120),'-',''),':',''),' ','');
 
    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate     = CAST('1/1/2020' as DateTime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;
 
    --==========================================
    -- Clean EE List
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================
 
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EPRUDELIXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRUDELIXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
 
    DELETE FROM dbo.U_EPRUDELIXP_EEList WHERE xEEID IN ( -- ABC
        SELECT DISTINCT eecEEID from EmpComp WHERE EecEEType IN ('TES', 'CON', 'INT')
    )

    DELETE FROM dbo.U_EPRUDELIXP_EEList WHERE xEEID IN ( -- ABC
        SELECT DISTINCT eecEEID from EmpComp WHERE EecEmplStatus IN ('T')
    )
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CIE,CIS,CIC,ACDNT,STDER,LTDER,HOSP,ABS';
 
    IF OBJECT_ID('U_EPRUDELIXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRUDELIXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;
 
 
    --==========================================
    -- Create audit tables
    --==========================================
    IF OBJECT_ID('U_EPRUDELIXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_AuditFields;
    CREATE TABLE dbo.U_EPRUDELIXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EPRUDELIXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    -- Create audit table
    IF OBJECT_ID('U_EPRUDELIXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EPRUDELIXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EPRUDELIXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EPRUDELIXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EPRUDELIXP_Audit ON dbo.U_EPRUDELIXP_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;
 
    -- Required parameters
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
 
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse', 'SPS')
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'DIS,STC,CHL')
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDomPartner', 'DP')
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDPChild', 'DPC')
 
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
 
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode
 
 
 
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDELIXP_drvAstTbl
    ---------------------------------

    /*WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDELIXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))
    */



    IF OBJECT_ID('U_EPRUDELIXP_drvAstTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_drvAstTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + eepSSN
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvASTAssociateId = EecEmpNo
        ,drvASTSSNumber = eepSSN
        ,drvASTGendeCode = CASE WHEN EepGender = 'F' then 'FEMALE'
                                WHEN EepGender = 'M' then 'MALE'
                                ELSE 'UNKNOWN'
                            END
        ,drvASTDateOfBirth = EepDateOfBirth
        ,drvASTDateofDeath = EepDateDeceased
        ,drvASTSmokerStatus = CASE WHEN EepIsSmoker = 'Y' THEN 'SMOKER'
                                   WHEN EepIsSmoker = 'N' THEN 'NONSMOKER'
                                ELSE 'UNKNOWN'
                             END
        ,drvASTMaritalStatus = CASE WHEN eepMaritalStatus = 'S' THEN 'SINGLE'
                                    WHEN eepMaritalStatus = 'M' THEN 'MARRIED'
                                    WHEN eepMaritalStatus = 'D' THEN 'DIVORCED'
                                   WHEN eepMaritalStatus = 'W' THEN 'WIDOWED'
                                    ELSE 'UNKNOWN'
                             END
        ,drvASTFirstName = EepNameFirst
        ,drvASTMiddleName = EepNameMiddle
        ,drvASTLastName = EepNameLast
        ,drvASTSuffix = EepNameSuffix
        ,drvAddressTypeCode = 'HOME'
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = eecEmplStatus --EepAddressCity
        ,drvStateProvinceCode = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountryCode = 'USA'
        ,drvPhoneTypeCode1 = 'HOME'
        ,drvPhoneNumber1 = EepPhoneHomeNumber   
        ,drvPhoneTypeCode2 = CASE WHEN ISNULL( (select top 1 efoPhoneNumber from EmpMPhon (NOLOCK) where efoPhoneType = 'CEL' and efoEEID in (xEEID) ),'') <> '' THEN 'MOBILE' END
        ,drvPhoneNumber2 = (select top 1 efoPhoneNumber from EmpMPhon (NOLOCK) where efoPhoneType = 'CEL' and efoEEID in (xEEID) )
        ,drvEmailTypeCode1 = CASE WHEN ISNULL(eepAddressEMailAlternate,'') <> '' THEN 'PERSONAL' END
        ,drvEmail1 = eepAddressEMailAlternate
    INTO dbo.U_EPRUDELIXP_drvAstTbl
    FROM dbo.U_EPRUDELIXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDELIXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDELIXP_drvEmpTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUDELIXP_drvEmpTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_drvEmpTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + eepSSN
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvEmpAssociateId = EecEmpNo
        ,drvEmpIdentifier = EecEmpNo
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateofLastHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN  EecDateOfLastHire END
        ,drvDateOfRetirement = CASE WHEN  EecEmplStatus = 'T' and  EecTermReason = '202' THEN EecDateOfTermination END
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationReasonCode = CASE WHEN EecEmplStatus = 'T' THEN     
                                        CASE WHEN eecTermReason = '202' then 'RETIRED'
                                             WHEN eecTermReason  = '203' THEN 'DECEASED'
                                             WHEN eecTermReason NOT IN  ('202','203') THEN 'TERMINATED'
                                        END
                                    END
        ,drvEmpStatusCode = CASE WHEN EecEmplStatus = 'T' THEN     
                                        CASE WHEN eecTermReason = '202' then 'RETIRED'
                                             WHEN eecTermReason = '203' THEN 'DECEASED'
                                             WHEN eecTermReason NOT IN  ('202','203') THEN 'TERMINATED'
                                        END
                                 WHEN EecEmplStatus = 'L' THEN 'LEAVE OF ABSENCE'
                                 ELSE 'ACTIVE'
                            END
 
        ,drvWeeklySchedHours = CAST(EecScheduledWorkHrs / 2 AS VARCHAR(12))
        ,drvDailyHoursWorked =  CAST(EecScheduledWorkHrs / 14 AS VARCHAR(12))
        ,drvEarningTypeCode1 = 'BASE PAY'
        ,drvEarningEffectiveDate1 = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire)
        ,drvEarningAmount1 = CAST(EecAnnSalary as varchar(12))
        ,drvEarningFrequencyCode1 = 'ANNUAL'
        ,drvEarningTypeCode2 = ''
        ,drvEarningEffectiveDate2 = ''
        ,drvEarningAmount2 = ''
        ,drvEarningFrequencyCode2 = ''
        ,drvWorkState = (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation))
        ,drvUnionIndicator = 'N'
        ,drvMemberGroupCode = '001'
        ,drvBillGroupCode = 'List Bill'
        ,drvPayrollFreqCode = 'MNTHLY_1ST'
    INTO dbo.U_EPRUDELIXP_drvEmpTbl
    FROM dbo.U_EPRUDELIXP_EEList WITH (NOLOCK)
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
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDELIXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDELIXP_drvAbsTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUDELIXP_drvAbsTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_drvAbsTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + eepSSN
        ,drvSubSort = '4'
        -- standard fields above and additional driver fields below
        ,drvAbsEmpNo =  EecEmpNo
        ,drvReportingCode1 = eecorglvl1
        ,drvHRRepNameLast = 'HR REP'
        ,drvContactEmail = 'benefits@peopleincorporated.org'
        ,drvEmploymentType = 'Z3999'
        ,drvEmploymentSector = 'Z2002'
        ,drvFMLABranchCode = '00001'
        ,drvFMLAWorkLocationCode = 'People Inc'
        ,drvEEIndicator = 'N'
        ,drvStandardWorkSchedule = 'Y'
        ,drvHoursWorkLast12Months = '1250'
        ,drvAsOfDateHoursLast12Months = GETDATE()
    INTO dbo.U_EPRUDELIXP_drvAbsTbl
    FROM dbo.U_EPRUDELIXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDELIXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDELIXP_drvCovTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUDELIXP_drvCovTbl','U') IS NOT NULL -- ABC drvCovProdCovAmtRaw
        DROP TABLE dbo.U_EPRUDELIXP_drvCovTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + eepSSN
        ,drvSubSort = '5'
        -- standard fields above and additional driver fields below
        ,drvCovEmpNo = EecEmpNo
        ,drvCovProductCode = CASE WHEN EedDedCode IN ('CIE', 'CIS' , 'CIC') THEN 'VCI'
                                  WHEN EedDedCode IN ('ACDNT') THEN 'VACC'
                                  WHEN EedDedCode IN ('STDER') THEN 'WDI'
                                  WHEN EedDedCode IN ('LTDER') THEN 'LTD'
                                  WHEN EedDedCode IN ('HOSP') THEN  'VHIP'
                                  ELSE 'ABS'
                             END
        ,drvCovProductTier = CASE WHEN EedDedCode IN ('CIE') THEN 'EE'
                                  WHEN EedDedCode IN ('CIS') THEN 'SP'
                                  WHEN EedDedCode IN ('CIC') THEN 'CH'
                                  WHEN EedDedCode IN ('ACDNT','HOSP') And EedBenOption IN ('EE') THEN 'EE'
                                  WHEN EedDedCode IN ('ACDNT','HOSP') And EedBenOption IN ('EES') THEN 'ES'
                                  WHEN EedDedCode IN ('ACDNT','HOSP') And EedBenOption IN ('EEC') THEN 'EC'
                                  WHEN EedDedCode IN ('ACDNT','HOSP') And EedBenOption IN ('EEF') THEN 'FM'
                             END
        ,drvCovProdPlanCode = CASE WHEN EedDedCode IN ('CIE', 'CIS' ,'CIC') THEN '4024'
                                   WHEN EedDedCode IN ('ACDNT') THEN '4025'
                             END
        ,drvCovBuyUpIndc = 'N'
        ,drvCovProdCovAmt = CASE WHEN EedDedCode IN ('CIE','CIS','CIC') THEN CAST(EedBenAmt as VARCHAR(12)) END
        ,drvCovProdCovAmtRaw = CASE WHEN EedDedCode IN ('CIE','CIS','CIC') THEN ISNULL(EedBenAmt, 0) ELSE 0  END
        ,drvCovEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',eedBenStartDate, @FileMinCovDate)
        ,drvCovEndDate = eedBenStopDate
        ,drvCovStatusCode = CASE WHEN EedBenStatus = 'T' THEN 'TERMINATED' END
        ,drvCovStatusEffectiveDate = ''
        ,drvCovStatusReasonCode = ''
        ,drvVoluntaryBasis = CASE WHEN EedDedCode = 'ACDNT' THEN 'TREATMENT' END
    INTO dbo.U_EPRUDELIXP_drvCovTbl
    FROM dbo.U_EPRUDELIXP_EEList WITH (NOLOCK)
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'  
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDELIXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))  
 
            --Include employee U_EPRUDELIXP_drvCovTbl only have YTD earnings
    /*DELETE FROM dbo.U_EPRUDELIXP_drvCovTbl WHERE drvEEID NOT IN (
            SELECT DISTINCT
                 PehEEID
            FROM dbo.PayReg WITH (NOLOCK)
            JOIN dbo.PEarHist WITH (NOLOCK)
                ON PehGenNumber = PrgGenNumber
            WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
            AND PehPerControl <= @EndPerControl
            GROUP BY PehEEID
            HAVING SUM(PehCurAmt) <> 0.00
    );*/
 
 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDELIXP_drvDepTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUDELIXP_drvDepTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_drvDepTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =  '2-' + eepSSN
        ,drvSubSort = '6'
        -- standard fields above and additional driver fields below
        ,drvDepEmpNo = EecEmpNo
        ,drvConSSN = ConSSN
 
        ,drvDepRelationshipTypeCode = CASE WHEN ConRelationship = 'DP' THEN 'DOMESTIC PARTNER'
                                           WHEN ConRelationship IN ('SPS','HUS','WIF') THEN 'SPOUSE'    
                                           WHEN ConRelationship In ('DIS', 'STC', 'SON','DAU','LDP','CHL') THEN 'CHILD'
                                      END
        ,drvDEPSSN = eepSSN
        ,drvConGender = CASE WHEN ConGender = 'F' THEN 'FEMALE'
                             WHEN ConGender = 'M' THEN 'MALE'
                             ELSE 'UNKNOWN'
                        END
        ,drvDateConBirthDate = ConDateOfBirth
        ,drvDateConDeathDate = ConDeathDate
        ,drvConDrvStatusCode = CASE WHEN ConIsSmoker = 'Y' THEN 'SMOKER'
                                    WHEN ConIsSmoker = 'N' THEN 'NON SMOKER'
                                    ELSE 'UNKNOWN'
                                END
        ,drvConMaritalStatusCode = CASE WHEN eepMaritalStatus = 'S' THEN 'SINGLE'
                                    WHEN eepMaritalStatus = 'M' THEN 'MARRIED'
                                    WHEN eepMaritalStatus = 'D' THEN 'DIVORCED'
                                   WHEN eepMaritalStatus = 'W' THEN 'WIDOWED'
                                    ELSE 'UNKNOWN'
                             END
        ,drvDepFirstName = ConNameFirst
        ,drvDepMiddleName = ConNameMiddle
        ,drvDepLastName = ConNameLast
        ,drvDepSuffixName = ConNameSuffix
        ,drvDepAddressTypeCode = 'HOME'
        ,drvDepAddressLine1 = EepAddressLine1
        ,drvDepAddressLine2 = EepAddressLine2
        ,drvDepCity = EepAddressCity
        ,drvDepState = EepAddressState
        ,drvDepZipCode = EepAddressZipCode
        ,drvDepTelephoneType1 = 'HOME'
        ,drvDepTelephoneNumber1 = EepPhoneHomeNumber
        ,drvDepEmailAddressType1 = CASE WHEN ISNULL(eepAddressEMailAlternate,'') <> '' THEN 'PERSONAL' END
        ,drvDepEmailAddress1 = eepAddressEMailAlternate
    INTO dbo.U_EPRUDELIXP_drvDepTbl
    FROM dbo.U_EPRUDELIXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnCoID = xCoID
        AND DbnFormatCode = @FormatCode
        AND DbnValidForExport = 'Y'
        AND DbnDedCode in ('ACDNT', 'CIS', 'CIC','HOSP')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = DbnDepRecID;
    WHERE (eecemplstatus <> 'T'  
            OR EXISTS(
                select 1 
                from dbo.U_EPRUDELIXP_Audit 
                where audKey1Value = xEEID 
                AND audKey2Value = xcoid 
                and audfieldname = 'eecemplstatus' 
                and audNewValue = 'T'
                and audDateTime between @StartDate and @EndDate))
   
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPRUDELIXP_Headerl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_Headerl;
    SELECT DISTINCT
 
         drvRecordType = 'HDR'
        ,drvTransmissionGUID = ''
        ,drvFileCreationDateTime = @FileDateStart
        ,drvControlNumber = '59904'
        ,drvFileTypeVersion = '1.1'
        ,drvSenderName = 'People Incorporated'
        ,drvSenderPlatformName = ''
        ,drvTestProductionCode = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'Test' ELSE 'Production' END
        ,drvTransmissionTypeCode = ''
        ,drvActivityDateTime = @FileDateStartSevenDays
        ,drvActivityEndDateTime = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar,GETDATE(), 120),'-',''),':',''),' ','')
    INTO dbo.U_EPRUDELIXP_Headerl
    ;
 
 
    --Remove ABS coverage without AST EMP or ABS Line
    Delete from U_EPRUDELIXP_drvCovTbl where  drvCovProductCode = 'ABS' and  drveeid  not in (select drveeid from U_EPRUDELIXP_drvAstTbl)
 
    --Update Suffix to '' for 'Z'
    Update U_EPRUDELIXP_drvDepTbl set drvDepSuffixName = '' where drvDepSuffixName = 'Z'
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPRUDELIXP_drvTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_drvTrailer;
    SELECT DISTINCT
         drvFileCreationDateTrailer =  CONVERT(nvarchar, GETDATE(), 112)
        ,drvRecordCount = CAST (
                            (Select count(*) from dbo.U_EPRUDELIXP_drvAstTbl (NOLOCK))  +  (Select count(*) from dbo.U_EPRUDELIXP_drVEMPTbl (NOLOCK)) + (Select count(*) from dbo.U_EPRUDELIXP_drvABSTbl (NOLOCK)) +
                            (Select count(*) from dbo.U_EPRUDELIXP_drvCOVTbl (NOLOCK)) + (Select count(*) from dbo.U_EPRUDELIXP_drvDEPTbl (NOLOCK)) as VARCHAR(12))
 
        ,drvASTCount = CAST ((Select count(*) from dbo.U_EPRUDELIXP_drvAstTbl (NOLOCK)) as varchar(12))
        ,drvEMPRecordCount = CAST ((Select count(*) from dbo.U_EPRUDELIXP_drVEMPTbl (NOLOCK)) as varchar(12))
        ,drvABSCount = CAST ((Select count(*) from dbo.U_EPRUDELIXP_drvABSTbl (NOLOCK)) as varchar(12))
        ,drvCOVCount = CAST ((Select count(*) from dbo.U_EPRUDELIXP_drvCOVTbl (NOLOCK)) as varchar(12))
        ,drvDEPCount = CAST ((Select count(*) from dbo.U_EPRUDELIXP_drvDEPTbl (NOLOCK)) as varchar(12)) -- ABC
        ,drvTotalBenAmt =  CAST ( (Select SUM(drvCovProdCovAmtRaw) from U_EPRUDELIXP_drvCovTbl) as varchar(12))
    INTO dbo.U_EPRUDELIXP_drvTrailer
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
ALTER VIEW dbo.dsi_vwEPRUDELIXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPRUDELIXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort;
 
--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPRUDELIXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;
 
--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201910161'
       ,expStartPerControl     = '201910161'
       ,expLastEndPerControl   = '201910239'
       ,expEndPerControl       = '201910239'
WHERE expFormatCode = 'EPRUDELIXP';
 
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPRUDELIXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPRUDELIXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort;