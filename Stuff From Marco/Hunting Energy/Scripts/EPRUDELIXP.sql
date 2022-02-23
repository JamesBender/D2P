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
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EPRUDELIXP','Prudential Vol Accident','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EPRUDELIXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EPRUDELIXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''T~'')','EPRUDELIXPZ0','3','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileType"','2','(''UA''=''T~'')','EPRUDELIXPZ0','4','H','01','2',NULL,'Transmission GUID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileTypeVersion"','3','(''UA''=''T~'')','EPRUDELIXPZ0','6','H','01','3',NULL,'File Type Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvControlNumber"','4','(''UA''=''T~'')','EPRUDELIXPZ0','10','H','01','4',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDateTime"','5','(''UA''=''T~'')','EPRUDELIXPZ0','14','H','01','5',NULL,'File Creation Date Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActivityDateTime"','6','(''UA''=''T~'')','EPRUDELIXPZ0','14','H','01','6',NULL,'Activity Start Date Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActivityEndDateTime"','7','(''UA''=''T'')','EPRUDELIXPZ0','14','H','01','7',NULL,'Activity End Date Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AST"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"70442"','2','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','10','2',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTAssociateId"','3','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','10','3',NULL,'Associate Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTSSNumber"','4','(''UA''=''T~'')','EPRUDELIXPZ0','9','D','10','4',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTGendeCode"','5','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','10','5',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTDateOfBirth"','6','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','10','6',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTDateofDeath"','7','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','10','7',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTSmokerStatus"','8','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','10','8',NULL,'Smoker Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTMaritalStatus"','9','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','10','9',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','10','10',NULL,'Prefix Title Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','10','10',NULL,'Suffix Title Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTLastName"','12','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','10','11',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTFirstName"','13','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','10','12',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTMiddleName"','14','(''UA''=''T~'')','EPRUDELIXPZ0','80','D','10','13',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','10','14',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressTypeCode"','16','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','10','15',NULL,'Address Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','17','(''UA''=''T~'')','EPRUDELIXPZ0','64','D','10','16',NULL,'Address Line 1 Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','18','(''UA''=''T~'')','EPRUDELIXPZ0','64','D','10','17',NULL,'Address Line 2 Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine3"','19','(''UA''=''T~'')','EPRUDELIXPZ0','64','D','10','18',NULL,'Address Line 3 Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','20','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','10','19',NULL,'City Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateProvinceCode"','21','(''UA''=''T~'')','EPRUDELIXPZ0','2','D','10','20',NULL,'State Province Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','22','(''UA''=''T~'')','EPRUDELIXPZ0','12','D','10','21',NULL,'Postal Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','23','(''UA''=''T~'')','EPRUDELIXPZ0','35','D','10','22',NULL,'Country Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','10','23',NULL,'Address Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','24',NULL,'Address Line 1 Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','25',NULL,'Address Line 2 Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','10','26',NULL,'Address Line 3 Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T~'')','EPRUDELIXPZ0','50','D','10','27',NULL,'City Name 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T~'')','EPRUDELIXPZ0','2','D','10','28',NULL,'State Province Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T~'')','EPRUDELIXPZ0','12','D','10','29',NULL,'Postal Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDELIXPZ0','35','D','10','30',NULL,'Country Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneTypeCode1"','32','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','10','31',NULL,'Telephone Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber1"','33','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','10','32',NULL,'Telephone Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','10','33',NULL,'Telephone Number Extension 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneTypeCode2"','35','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','10','34',NULL,'Telephone Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber2"','36','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','10','35',NULL,'Telephone Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','10','36',NULL,'Telephone Number Extension 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailTypeCode1"','38','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','10','37',NULL,'Email Address Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail1"','39','(''UA''=''T~'')','EPRUDELIXPZ0','350','D','10','38',NULL,'Email Address Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailTypeCode2"','40','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','10','39',NULL,'Email Address Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail2"','41','(''UA''=''T'')','EPRUDELIXPZ0','350','D','10','40',NULL,'Email Address Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMP"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','15','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"70442"','2','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','15','2',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAssociateId"','3','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','15','3',NULL,'Associate Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpIdentifier"','4','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','15','4',NULL,'Employee Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','5','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','5',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofLastHire"','6','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','6',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfRetirement"','7','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','7',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','8','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','8',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReasonCode"','9','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','15','9',NULL,'Employment Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','15','10',NULL,'Adjusted Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatusCode"','11','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','11',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStatusEffectiveDate"','12','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','13',NULL,'Employment Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','15','14',NULL,'Employment Status Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','15','15',NULL,'Job Title Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','15','16',NULL,'Occupation Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','18',NULL,'Occupation Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','19',NULL,'Work Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklySchedHours"','18','(''UA''=''T~'')','EPRUDELIXPZ0','5','D','15','20',NULL,'Weekly Scheduled Hours Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','22',NULL,'Hourly Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningTypeCode1"','20','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','23',NULL,'Earnings Type  Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningEffectiveDate1"','21','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','24',NULL,'Earnings Effective  Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmount1"','22','(''UA''=''T~'')','EPRUDELIXPZ0','17','D','15','25',NULL,'Earnings  Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningFrequencyCode1"','23','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','26',NULL,'Earnings Frequency Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningTypeCode2"','24','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','27',NULL,'Earnings Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningEffectiveDate2"','25','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','15','28',NULL,'Earnings Effective Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmount2"','26','(''UA''=''T~'')','EPRUDELIXPZ0','17','D','15','29',NULL,'Earnings Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningFrequencyCode2"','27','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','30',NULL,'Earnings Frequency  Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionIndicator"','28','(''UA''=''T~'')','EPRUDELIXPZ0','1','D','15','37',NULL,'Union Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','38',NULL,'Local Bargaining Unit Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberGroupCode"','30','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','15','39',NULL,'Member Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupCode"','31','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','15','40',NULL,'Bill Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFreqCode"','32','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','15','41',NULL,'Payroll Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','15','42',NULL,'District Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"001"','34','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','15','43',NULL,'Employment Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','15','44',NULL,'Regional Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T~'')','EPRUDELIXPZ0','20','D','15','45',NULL,'Employer Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T'')','EPRUDELIXPZ0','80','D','15','46',NULL,'Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COV"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','25','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"70442"','2','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','25','2',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovEmpNo"','3','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','25','3',NULL,'Associate Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovProductCode"','4','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','25','4',NULL,'Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovProductTier"','5','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','25','5',NULL,'Coverage Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovProdPlanCode"','6','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','25','6',NULL,'Product Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovProdCovAmt"','7','(''UA''=''T~'')','EPRUDELIXPZ0','17','D','25','8',NULL,'Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T~'')','EPRUDELIXPZ0','8','D','25','9',NULL,'Salary Multiple Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovEffectiveDate"','9','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','25','9',NULL,'Coverage  Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovEndDate"','10','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','25','10',NULL,'Coverage  End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovStatusCode"','11','(''UD112''=''T~'')','EPRUDELIXPZ0','25','D','25','11',NULL,'Coverage Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovStatusEffectiveDate"','12','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','25','12',NULL,'Coverage Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovStatusReasonCode"','13','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','25','13',NULL,'Coverage Status Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','25','14',NULL,'Coverage Termination Reduction Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T~'')','EPRUDELIXPZ0','17','D','25','15',NULL,'Coverage Termination Reduction Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','16','(''DA''=''T~'')','EPRUDELIXPZ0','1','D','25','19',NULL,'Assignment Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','25','26',NULL,'Issuance Age',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryBasis"','18','(''UA''=''T'')','EPRUDELIXPZ0','25','D','25','27',NULL,'Voluntary Basis',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"70442"','2','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','30','2',NULL,'Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEmpNo"','3','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','30','3',NULL,'Associate Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepIdentifier"','4','(''UA''=''T~'')','EPRUDELIXPZ0','32','D','30','3',NULL,'Dependent Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationshipTypeCode"','5','(''UA''=''T~'')','EPRUDELIXPZ0','35','D','30','5',NULL,'Relationship Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEPSSN"','6','(''UA''=''T~'')','EPRUDELIXPZ0','9','D','30','6',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConGender"','7','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','30','7',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateConBirthDate"','8','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','30','8',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEffDate"','9','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','30','9',NULL,'Dependent Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateConDeathDate"','10','(''UD112''=''T~'')','EPRUDELIXPZ0','8','D','30','9',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConDrvStatusCode"','11','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','30','10',NULL,'Smoker Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvConMaritalStatusCode"','12','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','30','11',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','30','12',NULL,'Prefix Title Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName"','14','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','30','13',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName"','15','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','30','14',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMiddleName"','16','(''UA''=''T~'')','EPRUDELIXPZ0','80','D','30','15',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepSuffixName"','17','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','30','16',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepAddressTypeCode"','18','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','30','17',NULL,'Address Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepAddressLine1"','19','(''UA''=''T~'')','EPRUDELIXPZ0','64','D','30','18',NULL,'Address Line 1 Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepAddressLine2"','20','(''UA''=''T~'')','EPRUDELIXPZ0','64','D','30','19',NULL,'Address Line 2 Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T~'')','EPRUDELIXPZ0','64','D','30','20',NULL,'Address Line 3 Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepCity"','22','(''UA''=''T~'')','EPRUDELIXPZ0','50','D','30','21',NULL,'City Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepState"','23','(''UA''=''T~'')','EPRUDELIXPZ0','2','D','30','22',NULL,'State Province Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepZipCode"','24','(''UA''=''T~'')','EPRUDELIXPZ0','12','D','30','23',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USA"','25','(''DA''=''T~'')','EPRUDELIXPZ0','35','D','30','24',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepTelephoneType1"','26','(''UA''=''T~'')','EPRUDELIXPZ0','30','D','30','25',NULL,'Telephone Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepTelephoneNumber1"','27','(''UA''=''T~'')','EPRUDELIXPZ0','20','D','30','26',NULL,'Telephone Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','28','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','30','27',NULL,'Telephone Number Extension 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','29','(''DA''=''T~'')','EPRUDELIXPZ0','30','D','30','28',NULL,'Telephone Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T~'')','EPRUDELIXPZ0','20','D','30','29',NULL,'Telephone Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDELIXPZ0','10','D','30','30',NULL,'Telephone Number Extension 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEmailAddressType1"','32','(''UA''=''T~'')','EPRUDELIXPZ0','25','D','30','34',NULL,'Email Address Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEmailAddress1"','33','(''UA''=''T~'')','EPRUDELIXPZ0','350','D','30','35',NULL,'Email Address Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','30','36',NULL,'Email Address Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T~'')','EPRUDELIXPZ0','350','D','30','37',NULL,'Email Address Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','30','38',NULL,'Dependent Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T~'')','EPRUDELIXPZ0','25','D','30','40',NULL,'Student Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabledDep"','38','(''UA''=''T~'')','EPRUDELIXPZ0','1','D','30','41',NULL,'Incapacitated Dependent Clause Certification Indic',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T'')','EPRUDELIXPZ0','1','D','30','41',NULL,'Incapacitated Dependent Clause Certification Indic',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRL"','1','(''DA''=''T~'')','EPRUDELIXPZ0','3','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileCreationDateTrailer"','2','(''UA''=''T~'')','EPRUDELIXPZ0','8','T','90','2',NULL,'File Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','3','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','4',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvASTCount"','4','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','5',NULL,'Associate Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPRecordCount"','5','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','6',NULL,'Employment Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','6','(''DA''=''T~'')','EPRUDELIXPZ0','10','T','90','7',NULL,'Employment Salary Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','7','(''DA''=''T~'')','EPRUDELIXPZ0','10','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOVCount"','8','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','13',NULL,'Coverage Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEPCount"','9','(''UA''=''T~'')','EPRUDELIXPZ0','9','T','90','16',NULL,'Dependent Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','10','(''DA''=''T~'')','EPRUDELIXPZ0','9','T','90','17',NULL,'Beneficiary Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','11','(''DA''=''T'')','EPRUDELIXPZ0','9','T','90','18',NULL,'Contact Record Count',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EPRUDELIXP_20210318.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202001319','EMPEXPORT','OEACTIVE','Dec 19 2019  9:02AM','EPRUDELIXP',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','2968','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202001319','EMPEXPORT','OEPASSIVE','Dec 27 2019  5:03PM','EPRUDELIXP',NULL,NULL,NULL,'202001319','Jan 31 2020 12:00AM','Dec 30 1899 12:00AM','202001011','3827','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Prudential Vol Acc ONDEMAND','201910239','EMPEXPORT','ONDEMAND','Feb 20 2021 12:00AM','EPRUDELIXP',NULL,NULL,NULL,'201910239','Oct 23 2019 12:00AM','Dec 30 1899 12:00AM','201910231',NULL,'','','201910231',dbo.fn_GetTimedKey(),NULL,'us3lKiSTO1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',0FSQ5',NULL,NULL,NULL,'Prudential Vol Accident','202002059','EMPEXPORT','SCH_PRUDX','Feb 20 2021 12:00AM','EPRUDELIXP',NULL,NULL,NULL,'202002059','Feb  5 2020 12:00AM','Dec 30 1899 12:00AM','202001291',NULL,'','','202001291',dbo.fn_GetTimedKey(),NULL,'us3lKiSTO1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','HE3TV,ZWM04,IAGFG',NULL,NULL,NULL,'Prudential Vol Acc-Test','202103129','EMPEXPORT','TEST','Mar 12 2021 12:49PM','EPRUDELIXP',NULL,NULL,NULL,'202103129','Mar 12 2021 12:00AM','Dec 30 1899 12:00AM','202102261','425','','','202102261',dbo.fn_GetTimedKey(),NULL,'us3lKiSTO1003',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDELIXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EPRUDELIXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EPRUDELIXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EPRUDELIXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPRUDELIXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','H01','dbo.U_EPRUDELIXP_Headerl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','D10','dbo.U_EPRUDELIXP_drvAstTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDELIXP','D15','dbo.U_EPRUDELIXP_drvEmpTbl',NULL);
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
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvASTAssociateId] char(9) NULL,
    [drvASTSSNumber] char(11) NULL,
    [drvASTGendeCode] varchar(7) NOT NULL,
    [drvASTDateOfBirth] datetime NULL,
    [drvASTDateofDeath] datetime NULL,
    [drvASTSmokerStatus] varchar(7) NOT NULL,
    [drvASTMaritalStatus] varchar(7) NOT NULL,
    [drvASTPrefix] varchar(1) NOT NULL,
    [drvASTSuffix] varchar(1) NOT NULL,
    [drvASTLastName] varchar(100) NULL,
    [drvASTFirstName] varchar(100) NULL,
    [drvASTMiddleName] varchar(50) NULL,
    [drvAddressTypeCode] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateProvinceCode] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountryCode] varchar(3) NOT NULL,
    [drvPhoneTypeCode1] varchar(6) NULL,
    [drvPhoneNumber1] varchar(50) NULL,
    [drvPhoneTypeCode2] varchar(1) NOT NULL,
    [drvPhoneNumber2] varchar(1) NOT NULL,
    [drvEmailTypeCode1] varchar(8) NULL,
    [drvEmail1] varchar(50) NULL,
    [drvEmailTypeCode2] varchar(1) NOT NULL,
    [drvEmail2] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvCovTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvCovTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvCovEmpNo] char(9) NULL,
    [drvCovProductCode] varchar(4) NOT NULL,
    [drvCovProductTier] varchar(2) NULL,
    [drvCovProdPlanCode] varchar(4) NULL,
    [drvCovBuyUpIndc] varchar(1) NOT NULL,
    [drvCovProdCovAmt] varchar(1) NOT NULL,
    [drvCovProdCovAmtRaw] int NOT NULL,
    [drvCovEffectiveDate] datetime NULL,
    [drvCovEndDate] datetime NULL,
    [drvCovStatusCode] varchar(10) NULL,
    [drvCovStatusEffectiveDate] varchar(1) NOT NULL,
    [drvCovStatusReasonCode] varchar(1) NOT NULL,
    [drvVoluntaryBasis] varchar(9) NOT NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvDepTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvDepTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepEmpNo] char(9) NULL,
    [drvDepIdentifier] varchar(24) NULL,
    [drvConSSN] char(11) NULL,
    [drvDepRelationshipTypeCode] varchar(16) NULL,
    [drvDEPSSN] char(11) NULL,
    [drvConGender] varchar(7) NOT NULL,
    [drvDateConBirthDate] datetime NULL,
    [drvDepEffDate] datetime NULL,
    [drvDateConDeathDate] varchar(1) NOT NULL,
    [drvConDrvStatusCode] varchar(7) NOT NULL,
    [drvConMaritalStatusCode] varchar(7) NOT NULL,
    [drvDepPrefix] varchar(1) NOT NULL,
    [drvDepSuffixName] varchar(1) NOT NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepMiddleName] varchar(50) NULL,
    [drvDepAddressTypeCode] varchar(4) NOT NULL,
    [drvDepAddressLine1] varchar(1) NOT NULL,
    [drvDepAddressLine2] varchar(1) NOT NULL,
    [drvDepCity] varchar(1) NOT NULL,
    [drvDepState] varchar(1) NOT NULL,
    [drvDepZipCode] varchar(1) NOT NULL,
    [drvDepTelephoneType1] varchar(1) NOT NULL,
    [drvDepTelephoneNumber1] varchar(1) NOT NULL,
    [drvDepEmailAddressType1] varchar(1) NOT NULL,
    [drvDepEmailAddress1] varchar(1) NOT NULL,
    [drvDisabledDep] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvEmpTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvEmpTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(14) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpAssociateId] char(9) NULL,
    [drvEmpIdentifier] char(9) NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateofLastHire] datetime NULL,
    [drvDateOfRetirement] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvTerminationReasonCode] varchar(10) NULL,
    [drvEmpStatusCode] varchar(16) NULL,
    [drvEmpStatusEffectiveDate] datetime NULL,
    [drvWeeklySchedHours] varchar(1) NOT NULL,
    [drvDailyHoursWorked] varchar(1) NOT NULL,
    [drvEarningTypeCode1] varchar(1) NOT NULL,
    [drvEarningEffectiveDate1] varchar(1) NOT NULL,
    [drvEarningAmount1] varchar(1) NOT NULL,
    [drvEarningFrequencyCode1] varchar(1) NOT NULL,
    [drvEarningTypeCode2] varchar(1) NOT NULL,
    [drvEarningEffectiveDate2] varchar(1) NOT NULL,
    [drvEarningAmount2] varchar(1) NOT NULL,
    [drvEarningFrequencyCode2] varchar(1) NOT NULL,
    [drvWorkState] varchar(255) NULL,
    [drvUnionIndicator] varchar(1) NOT NULL,
    [drvMemberGroupCode] varchar(3) NOT NULL,
    [drvBillGroupCode] varchar(13) NOT NULL,
    [drvPayrollFreqCode] varchar(10) NOT NULL
);
IF OBJECT_ID('U_EPRUDELIXP_drvTrailer') IS NULL
CREATE TABLE [dbo].[U_EPRUDELIXP_drvTrailer] (
    [drvFileCreationDateTrailer] nvarchar(30) NULL,
    [drvRecordCount] varchar(12) NULL,
    [drvASTCount] varchar(12) NULL,
    [drvEMPRecordCount] varchar(12) NULL,
    [drvCOVCount] varchar(12) NULL,
    [drvDEPCount] varchar(12) NULL
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
    [drvFileType] varchar(3) NOT NULL,
    [drvFileTypeVersion] varchar(3) NOT NULL,
    [drvControlNumber] varchar(5) NOT NULL,
    [drvFileCreationDateTime] nvarchar(4000) NULL,
    [drvActivityDateTime] nvarchar(4000) NULL,
    [drvActivityEndDateTime] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDELIXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Synovos, Inc

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/06/2020
Service Request Number: SR-2020-00298075

Purpose: Prudential Vol Accident

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
            ,@FileMinCovDate    DATETIME
            ,@FileDateStart as VARCHAR(14)
            ,@FileDateStartSevenDays as VARCHAR(14);

 
    -- Set FormatCode
    SELECT @FormatCode = 'EPRUDELIXP';
    Select @FileDateStartSevenDays = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar, DATEADD(DAY,-6,GETDATE()), 120),'-',''),':',''),' ','');
    Select @FileDateStart = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar, GETDATE(), 120),'-',''),':',''),' ','');

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CAST('1/1/2021' as DateTime)
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

     DELETE FROM dbo.U_EPRUDELIXP_EEList
    WHERE  xEEID IN (SELECT eepeeid FROM dbo.EmpPers where eepssn = '123455679');


    DELETE FROM dbo.U_EPRUDELIXP_EEList WHERE xEEID IN ( -- ABC
        SELECT DISTINCT eecEEID from EmpComp WHERE EecEEType IN ('TES', 'CON', 'INT')
    )

/*
    DELETE FROM dbo.U_EPRUDELIXP_EEList WHERE xEEID IN ( -- ABC
        SELECT DISTINCT eecEEID from EmpComp WHERE EecEmplStatus IN ('T')
    )
*/
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GRPA1, GRPA2';

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
        ,drvInitialSort = '2-' + xeeid
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvASTAssociateId = EecEmpNo
        ,drvASTSSNumber = eepSSN
        ,drvASTGendeCode = CASE WHEN EepGender = 'F' then 'FEMALE'
                                WHEN EepGender = 'M' then 'MALE'
                                ELSE 'UNKNOWN'
                            END
        ,drvASTDateOfBirth = EepDateOfBirth
        ,drvASTDateofDeath = CASE WHEN eecemplstatus = 'T' and eecTermReason in ('203','DECEAS') THEN eecdateoftermination END
        ,drvASTSmokerStatus = 'UNKNOWN'
        ,drvASTMaritalStatus = CASE WHEN eepMaritalStatus = 'S' THEN 'SINGLE'
                                    WHEN eepMaritalStatus = 'M' THEN 'MARRIED'
                                    
                                    ELSE 'UNKNOWN'
                             END
        ,drvASTPrefix = ''
        ,drvASTSuffix = ''
        ,drvASTLastName = EepNameLast
        ,drvASTFirstName = EepNameFirst
        ,drvASTMiddleName = LTRIM(RTRIM(EepNameMiddle))
        ,drvAddressTypeCode = 'HOME'
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = EepAddressLine3
        ,drvCity = EepAddressCity
        ,drvStateProvinceCode = EepAddressState
        ,drvPostalCode = EepAddressZipCode
        ,drvCountryCode = 'USA'
        ,drvPhoneTypeCode1 = CASE WHEN eepphonehomenumber is not null then 'HOME'
                                 WHEN ISNULL( (select top 1 efoPhoneNumber from EmpMPhon (NOLOCK) where efoPhoneType = 'CEL' and efoEEID in (xEEID) ),'') <> '' THEN 'MOBILE' END
        ,drvPhoneNumber1 = CASE WHEN eepphonehomenumber is not null then eepphonehomenumber 
                                 WHEN ISNULL( (select top 1 efoPhoneNumber from EmpMPhon (NOLOCK) where efoPhoneType = 'CEL' and efoEEID in (xEEID) ),'') <> '' THEN (select top 1 efoPhoneNumber from EmpMPhon (NOLOCK) where efoPhoneType = 'CEL' and efoEEID in (xEEID) )
    
                                  END   
        ,drvPhoneTypeCode2 = ''
        ,drvPhoneNumber2 = ''
        ,drvEmailTypeCode1 = CASE WHEN ISNULL(eepAddressEMailAlternate,'') <> '' THEN 'PERSONAL' END
        ,drvEmail1 = eepAddressEMailAlternate
        ,drvEmailTypeCode2 = ''
        ,drvEmail2 = ''
    INTO dbo.U_EPRUDELIXP_drvAstTbl
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
    -- DETAIL RECORD - U_EPRUDELIXP_drvEmpTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUDELIXP_drvEmpTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDELIXP_drvEmpTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + xeeid
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvEmpAssociateId = EecEmpNo
        ,drvEmpIdentifier = EecEmpNo
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateofLastHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire and EecDateOfLastHire >= CAST('01/01/2021' as datetime) THEN EecDateOfLastHire END
        ,drvDateOfRetirement = CASE WHEN  EecEmplStatus = 'T' and  EecTermReason = '202' THEN EecDateOfTermination END
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationReasonCode = CASE WHEN EecEmplStatus = 'T' THEN     
                                        CASE WHEN eecTermReason = '202' then 'RETIRED'
                                             WHEN eecTermReason  in ('203','DECEAS') THEN 'DECEASED'
                                             WHEN eecTermReason NOT IN  ('202','203') THEN 'TERMINATED'
                                        END
                                    END
        ,drvEmpStatusCode = CASE WHEN EecEmplStatus = 'T' THEN     
                                        CASE WHEN eecTermReason = '202' then 'RETIRED'
                                             WHEN eecTermReason In ('203','DECEAS') THEN 'DECEASED'
                                             WHEN eecTermReason NOT IN  ('202','203') THEN 'TERMINATED'
                                        END
                                 WHEN EecEmplStatus = 'L' THEN 'LEAVE OF ABSENCE'
                                 ELSE 'ACTIVE'
                            END
        ,drvEmpStatusEffectiveDate =  CASE WHEN eecemplstatus = 'T' THEN eecdateoftermination
                                           WHEN eecemplstatus = 'L' THEN EecEmplStatusStartDate
                                           ELSE eecdateoflasthire
                                      END

        ,drvWeeklySchedHours = ''
        ,drvDailyHoursWorked =  ''
        ,drvEarningTypeCode1 = ''
        ,drvEarningEffectiveDate1 = ''
        ,drvEarningAmount1 = ''
        ,drvEarningFrequencyCode1 = ''
        ,drvEarningTypeCode2 = ''
        ,drvEarningEffectiveDate2 = ''
        ,drvEarningAmount2 = ''
        ,drvEarningFrequencyCode2 = ''
        ,drvWorkState = (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation))
        ,drvUnionIndicator = CASE WHEN EecUnionLocal is not null then 'Y' ELSE 'N' END
        ,drvMemberGroupCode = '001'--CASE WHEN EepAddressState  = 'WA' THEN '001' ELSE '002' END
        ,drvBillGroupCode = 'Synovos, Inc.'
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
    -- DETAIL RECORD - U_EPRUDELIXP_drvCovTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUDELIXP_drvCovTbl','U') IS NOT NULL -- ABC drvCovProdCovAmtRaw
        DROP TABLE dbo.U_EPRUDELIXP_drvCovTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2-' + xeeid
        ,drvSubSort = '5'
        -- standard fields above and additional driver fields below
        ,drvCovEmpNo = EecEmpNo
        ,drvCovProductCode = 'VACC'
        ,drvCovProductTier = CASE WHEN EedBenOption IN ('EE') THEN 'EE'
                                  WHEN EedBenOption IN ('EESP','EEDP','EES') THEN 'ES'
                                  WHEN EedBenOption IN ('EECR','EEC') THEN 'EC'
                                  WHEN EedBenOption IN ('FAM','EEDPF') THEN 'FM'
                             END
        ,drvCovProdPlanCode = CASE WHEN EedDedCode IN ('GRPA1') THEN '6027'
                                   WHEN EedDedCode IN ('GRPA2')  THEN '4565'
                             END
        ,drvCovBuyUpIndc = 'N'
        ,drvCovProdCovAmt = '0'
        ,drvCovProdCovAmtRaw = 0
        ,drvCovEffectiveDate = CASE WHEN eedDedCode in ('GRPA1','GRPA2') THEN dbo.dsi_fnGetMinMaxDates('MAX',eedBenStartDate, @FileMinCovDate) END 
        ,drvCovEndDate = eedBenStopDate
        ,drvCovStatusCode = CASE WHEN EedBenStatus = 'T' THEN 'TERMINATED' END
        ,drvCovStatusEffectiveDate = ''
        ,drvCovStatusReasonCode = ''
        ,drvVoluntaryBasis = 'TREATMENT'
    INTO dbo.U_EPRUDELIXP_drvCovTbl
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
        ,drvInitialSort =  '2-' + xeeid
        ,drvSubSort = '6'
        -- standard fields above and additional driver fields below
        ,drvDepEmpNo = EecEmpNo
        ,drvDepIdentifier = dbo.dsi_fnPadZero(Dep_Number + 1,2,0)
        ,drvConSSN = ConSSN

        ,drvDepRelationshipTypeCode = CASE WHEN ConRelationship = 'DP' THEN 'DOMESTIC PARTNER'
                                           WHEN ConRelationship IN ('SPS','HUS','WIF') THEN 'SPOUSE'    
                                           WHEN ConRelationship In ('DIS', 'STC', 'SON','DAU','LDP','CHL') THEN 'CHILD'
                                      END
        ,drvDEPSSN = ConSSN -- eepSSN
        ,drvConGender = CASE WHEN ConGender = 'F' THEN 'FEMALE'
                             WHEN ConGender = 'M' THEN 'MALE'
                             ELSE 'UNKNOWN'
                        END
        ,drvDateConBirthDate = ConDateOfBirth
        ,drvDepEffDate  = CASE WHEN dbnDedCode in ('GRPA1','GRPA2') THEN dbo.dsi_fnGetMinMaxDates('MAX',DbnBenStartDate, @FileMinCovDate) END --DbnBenStartDate
        ,drvDateConDeathDate = ''
        ,drvConDrvStatusCode = 'UNKNOWN'
        ,drvConMaritalStatusCode = CASE WHEN eepMaritalStatus = 'M' AND ConRelationship IN ('SPS','HUS','WIF') THEN 'MARRIED'
                                    ELSE 'UNKNOWN'
                             END
        ,drvDepPrefix = ''
        ,drvDepSuffixName = ''
        ,drvDepLastName = ConNameLast
        ,drvDepFirstName = ConNameFirst
        ,drvDepMiddleName = ConNameMiddle
        ,drvDepAddressTypeCode = 'HOME'
        ,drvDepAddressLine1 = ''
        ,drvDepAddressLine2 = ''
        ,drvDepCity = ''
        ,drvDepState = ''
        ,drvDepZipCode = ''
        ,drvDepTelephoneType1 = ''
        ,drvDepTelephoneNumber1 = ''
        ,drvDepEmailAddressType1 = ''
        ,drvDepEmailAddress1 = ''
        ,drvDisabledDep = CASE WHEN ConIsDisabled = 'Y' THEN 'Y' ELSE 'N' END
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
        AND DbnDedCode in ('GRPA1', 'GRPA2')
    LEFT JOIN (
                select ConEEID, 
                       ConNameLast, 
                       ConNameFirst, 
                       ConSSN, 
                       ConDateOfBirth, 
                       ConRelationship,
                       ConSystemID,
                       ConGender,
                       ConIsSmoker,
                       ConNameMiddle,
                       ConNameSuffix,
                       ConIsDisabled,
                       ROW_NUMBER()  OVER
                        (PARTITION BY ConEEID ORDER BY ConImportID,ConDateOfBirth, 
                            CASE WHEN ConRelationship in ('SPS','DP') THEN 1 ELSE 2 END ) AS 'Dep_Number'
                from dbo.Contacts Where ConIsDependent = 'Y' ) as Contacts
        ON ConEEID = xEEID
        AND ConSystemID = DbnDepRecID
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
        ,drvFileType = 'ELG'
        ,drvFileTypeVersion = '1.0'
        ,drvControlNumber = '70442'
        ,drvFileCreationDateTime = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar,GETDATE(), 120),'-',''),':',''),' ','')
        ,drvActivityDateTime = REPLACE(REPLACE(REPLACE(CONVERT(nvarchar,GETDATE() + 1, 120),'-',''),':',''),' ','')
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
        ,drvCOVCount = CAST ((Select count(*) from dbo.U_EPRUDELIXP_drvCOVTbl (NOLOCK)) as varchar(12))
        ,drvDEPCount = CAST ((Select count(*) from dbo.U_EPRUDELIXP_drvDEPTbl (NOLOCK)) as varchar(12)) -- ABC
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