SET NOCOUNT ON;
IF OBJECT_ID('U_EPRUDAHCEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EPRUDAHCEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EPRUDAHCEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEPRUDAHCEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRUDAHCEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRUDAHCEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDAHCEX];
GO
IF OBJECT_ID('U_EPRUDAHCEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_Trailer];
GO
IF OBJECT_ID('U_EPRUDAHCEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_PEarHist];
GO
IF OBJECT_ID('U_EPRUDAHCEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_PDedHist];
GO
IF OBJECT_ID('U_EPRUDAHCEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_Header];
GO
IF OBJECT_ID('U_EPRUDAHCEX_File') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_File];
GO
IF OBJECT_ID('U_EPRUDAHCEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_EEList];
GO
IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_EmploymentInfo') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_drvTbl_EmploymentInfo];
GO
IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_Dependent') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_drvTbl_Dependent];
GO
IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_Coverage') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_drvTbl_Coverage];
GO
IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_Associate') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_drvTbl_Associate];
GO
IF OBJECT_ID('U_EPRUDAHCEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EPRUDAHCEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPRUDAHCEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EPRUDAHCEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EPRUDAHCEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EPRUDAHCEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EPRUDAHCEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EPRUDAHCEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','EPRUDAHCEX','Prudential AccHospCI Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','N','S','N','EPRUDAHCEXZ0','N','Jan  1 1900 12:00AM','C','N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EPRUDAHCEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''T~'')','EPRUDAHCEXZ0','50','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''T~'')','EPRUDAHCEXZ0','50','H','01','2',NULL,'Transmission GUID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreationDateTime"','3','(''UA''=''T~'')','EPRUDAHCEXZ0','50','H','01','3',NULL,'Creation Date Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"60222"','4','(''DA''=''T~'')','EPRUDAHCEXZ0','50','H','01','4',NULL,'Client Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Becker & Poliakoff"','5','(''DA''=''T~'')','EPRUDAHCEXZ0','50','H','01','5',NULL,'Client Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','6','(''DA''=''T~'')','EPRUDAHCEXZ0','50','H','01','6',NULL,'SchemaVersionIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Becker & Poliakoff"','7','(''DA''=''T~'')','EPRUDAHCEXZ0','50','H','01','7',NULL,'Sender Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UKG"','8','(''DA''=''T~'')','EPRUDAHCEXZ0','50','H','01','8',NULL,'Sender Platform Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTestProductionCode"','9','(''UA''=''T~'')','EPRUDAHCEXZ0','50','H','01','9',NULL,'Test Production Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FULL FILE"','10','(''DA''=''T~'')','EPRUDAHCEXZ0','50','H','01','10',NULL,'Transmission Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActivityStartDateTime"','11','(''UA''=''T~'')','EPRUDAHCEXZ0','50','H','01','11',NULL,'Activity Start Date Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActivityEndDateTime"','12','(''UA''=''T'')','EPRUDAHCEXZ0','50','H','01','12',NULL,'Activity End Date Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AST"','1','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"60222"','2','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','2',NULL,'Client Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateId"','3','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','3',NULL,'AssociateID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateSSN"','4','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','4',NULL,'Associate Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateGenderCode"','5','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','5',NULL,'Associate Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateDateOfBirth"','6','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','10','6',NULL,'Associate Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','7',NULL,'Associate Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateSmokerStatus"','8','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','8',NULL,'Associate Smoker Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateMartialStatus"','9','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','9',NULL,'Associate Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','10',NULL,'Associate Prefix Title Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateSuffix"','11','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','11',NULL,'Associate Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','12','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','12',NULL,'Associate Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','13','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','13',NULL,'Associate First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','14','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','14',NULL,'Associate Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOME"','15','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','15',NULL,'Associate Address Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','16','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','16',NULL,'Associate Address Line 1 Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','17','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','17',NULL,'Associate Address Line 2 Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','18',NULL,'Associate Address Line 3 Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','19','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','19',NULL,'Associate City Name 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','20','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','20',NULL,'Associate State Province Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','21','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','21',NULL,'Associate Postal Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USA"','22','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','22',NULL,'Associate Country Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','23',NULL,'Associate Address Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','24',NULL,'Associate Address Line 1 Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','25',NULL,'Associate Address Line 2 Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','26',NULL,'Associate Address Line 3 Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','27',NULL,'Associate City Name 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','28',NULL,'Associate State Province Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','29',NULL,'Associate Postal Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','30',NULL,'Associate Country Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','31',NULL,'Associate Address Type Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','32',NULL,'Associate Address Line 1 Text 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','33',NULL,'Associate Address Line 2 Text 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','34',NULL,'Associate Address Line 3 Text 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','35',NULL,'Associate City Name 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','36',NULL,'Associate State Province Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','37',NULL,'Associate Postal Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','38',NULL,'Associate Country Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CELL"','39','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','39',NULL,'Associate Telephone Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociatePhone1"','40','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','10','40',NULL,'Associate Telephone Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','41',NULL,'Associate Telephone Number Extension 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','42',NULL,'Telephone Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','43',NULL,'Associate Telephone Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','44',NULL,'Associate Telephone Number Extension 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','45',NULL,'Associate Telephone Type Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','46',NULL,'Associate Telephone Number 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','47',NULL,'Associate Telephone Number Extension 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','48',NULL,'Associate Email Address Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','49',NULL,'Associate Email Address Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','10','50',NULL,'Associate Email Address Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T'')','EPRUDAHCEXZ0','50','D','10','51',NULL,'Associate Email Address Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMP"','1','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"60222"','2','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','2',NULL,'Client Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateId"','3','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','20','3',NULL,'AssociateID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','4','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','20','4',NULL,'EmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','5','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','20','5',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','6','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','20','6',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRetirementDate"','7','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','20','7',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTerminationDate"','8','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','20','8',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTerminationReason"','9','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','20','9',NULL,'Employment Termination Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','10',NULL,'Adjusted Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','11',NULL,'Last Active Service Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatusCode"','12','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','20','12',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatusEffDate"','13','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','20','13',NULL,'Employment Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','14',NULL,'Employment Status Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','15',NULL,'Job Title Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','16',NULL,'Occupation Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','17',NULL,'OSHA Job Classification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','18',NULL,'Occupation Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','19',NULL,'Work Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','20',NULL,'Weekly Scheduled Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','21',NULL,'Daily Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','22',NULL,'Hourly Salary Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','23',NULL,'Earnings Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','24',NULL,'Earnings Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','25',NULL,'Earnings Frequency Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','26',NULL,'Earnings Effective Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','27',NULL,'Earnings Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','28',NULL,'Earnings Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','29',NULL,'Earnings Frequency Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','30',NULL,'Earnings Effective Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','31',NULL,'Earnings Type Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','32',NULL,'Earnings Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','33',NULL,'Earnings Frequency Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','34',NULL,'Earnings Effective Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','35',NULL,'W4 Filing Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','36',NULL,'W4 Exemptions Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','37',NULL,'W4 Additional Withholding Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','38',NULL,'W4 Withholding State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','39',NULL,'W4 Withholding State Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','40',NULL,'W4 Withholding State Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','41',NULL,'W4 Work Location Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','42',NULL,'Union Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','43',NULL,'Local Bargaining Unit Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberGroupCode"','44','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','20','44',NULL,'Member Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Becker & Poliakoff"','45','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','45',NULL,'Bill Group Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MNTHLY_1ST"','46','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','46',NULL,'Payroll Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','47',NULL,'District Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"001"','48','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','48',NULL,'Employment Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','49',NULL,'Regional Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','50',NULL,'Employer Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','51',NULL,'Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','52',NULL,'Work Location State Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','53',NULL,'Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','20','54',NULL,'Year to Date Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T'')','EPRUDAHCEXZ0','50','D','20','55',NULL,'Earnings As of Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COV"','1','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"60222"','2','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','2',NULL,'Client Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateId"','3','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','30','3',NULL,'AssociateID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductCode"','4','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','30','4',NULL,'Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTierCode"','5','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','30','5',NULL,'Coverage Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductPlanCode"','6','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','30','6',NULL,'Product Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"false"','7','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','7',NULL,'Coverage Buy Up Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageAmount"','8','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','30','8',NULL,'Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEffectiveDate"','9','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','30','9',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageEndDate"','10','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','30','10',NULL,'Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStatusCode"','11','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','30','11',NULL,'Coverage Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageStatusEffDate"','12','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','30','12',NULL,'Coverage Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','13',NULL,'Coverage Status Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','14',NULL,'Coverage Termination Reduction Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','15',NULL,'Coverage Termination Reduction Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','16',NULL,'Flat Benefit Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','17',NULL,'Claim Branch Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','18',NULL,'EOB Correspondence Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','19',NULL,'Assignment Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','20',NULL,'Original LTD Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','21',NULL,'Partner Product Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','22',NULL,'Partner Short Benefit Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','23',NULL,'Client Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','24',NULL,'Benefit Option Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','25',NULL,'Coverage Increase Within 2 years Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','26',NULL,'Issuance Age',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryBasis"','27','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','30','27',NULL,'Voluntary Basis',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','28',NULL,'Applicant Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','29',NULL,'Applicant Inforce Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','30',NULL,'Applicant Additional Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','31',NULL,'Applicant Relationship Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','32',NULL,'Applicant EOI Branch Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','33',NULL,'Deduction Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','34',NULL,'Deduction Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','35',NULL,'Deduction Frequency Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','36',NULL,'Deduction Withholding State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','37',NULL,'Payroll Deduction Frequency Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','38',NULL,'Payroll Deduction Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','39',NULL,'Coverage Event ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','40',NULL,'Coverage Event Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','41',NULL,'Coverage Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','30','42',NULL,'Coverage Marriage Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T'')','EPRUDAHCEXZ0','50','D','30','43',NULL,'Coverage Divorce Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP"','1','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"60222"','2','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','2',NULL,'Client Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateId"','3','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','3',NULL,'AssociateID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentId"','4','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','4',NULL,'DependentID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentRelationship"','5','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','5',NULL,'Dependent Relationship Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentSSN"','6','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','6',NULL,'Dependent Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentGenderCode"','7','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','7',NULL,'Dependent Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentDateOfBirth"','8','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','40','8',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentDateOfDeath"','9','(''UD112''=''T~'')','EPRUDAHCEXZ0','50','D','40','9',NULL,'Dependent Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentSmokerStatus"','10','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','10',NULL,'Dependent Smoker Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','11',NULL,'Dependent Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','12',NULL,'Dependent Prefix Title Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentSuffix"','13','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','13',NULL,'Dependent Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentNameFirst"','14','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','14',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentNameLast"','15','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','15',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentNameMiddle"','16','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','16',NULL,'Dependent Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOME"','17','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','17',NULL,'Dependent Address Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentAddressLine1"','18','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','18',NULL,'DependentAddress Line 1 Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentAddressLine2"','19','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','19',NULL,'Dependent Address Line 2 Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','20',NULL,'DependentAddress Line 3 Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentAddressCity"','21','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','21',NULL,'Dependent City Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentAddressState"','22','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','22',NULL,'Dependent State Province Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentAddressZipCode"','23','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','23',NULL,'DependentPostal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"USA"','24','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','24',NULL,'Dependent Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','25',NULL,'Dependent Telephone Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','26',NULL,'Dependent Telephone Number 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','27',NULL,'Dependent Telephone Number Extension 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','28',NULL,'Dependent Telephone Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','29',NULL,'Dependent Telephone Number 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','30',NULL,'Dependent Telephone Number Extension 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','31',NULL,'Dependent Telephone Type Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','32',NULL,'Dependent Telephone Number 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','33',NULL,'Dependent Telephone Number Extension 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','34',NULL,'Dependent Email Address Type Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','35',NULL,'Dependent Email Address Text 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','36',NULL,'Dependent Email Address Type Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','37',NULL,'Dependent Email Address Text 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','38',NULL,'Dependent Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','39',NULL,'Dependent Delete Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','40',NULL,'Student Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIncapacitateDepCertInd"','41','(''UA''=''T~'')','EPRUDAHCEXZ0','50','D','40','41',NULL,'Incapacitated Dependent Clause Certification Indic',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','42',NULL,'Incapacitated Dependent Clause Certification Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','43',NULL,'Dependent Event ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','44',NULL,'Dependent Event Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','45',NULL,'Dependent Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','46',NULL,'Dependent Marriage Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','47',NULL,'Dependent Divorce Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','48',NULL,'Dependent PreferenceID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','49',NULL,'Dependent CorrespondenceTypeCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T~'')','EPRUDAHCEXZ0','50','D','40','50',NULL,'Dependent Preferred Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T'')','EPRUDAHCEXZ0','50','D','40','51',NULL,'Dependent Preferred Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRL"','1','(''DA''=''T~'')','EPRUDAHCEXZ0','50','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAuditId"','2','(''UA''=''T~'')','EPRUDAHCEXZ0','50','T','90','2',NULL,'Audit ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''T~'')','EPRUDAHCEXZ0','50','T','90','3',NULL,'Absence Related Employment Information Record Quan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAssociateRecordQuantity"','4','(''UA''=''T~'')','EPRUDAHCEXZ0','50','T','90','4',NULL,'Associate Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T~'')','EPRUDAHCEXZ0','50','T','90','5',NULL,'Beneficiary Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageRecordQuantity"','6','(''UA''=''T~'')','EPRUDAHCEXZ0','50','T','90','6',NULL,'Coverage Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentRecordQuantity"','7','(''UA''=''T~'')','EPRUDAHCEXZ0','50','T','90','7',NULL,'Dependent Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T~'')','EPRUDAHCEXZ0','50','T','90','8',NULL,'Employment Contact Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeInfoRecordQuantity"','9','(''UA''=''T~'')','EPRUDAHCEXZ0','50','T','90','9',NULL,'Employment Information Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''T~'')','EPRUDAHCEXZ0','50','T','90','10',NULL,'Event Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T~'')','EPRUDAHCEXZ0','50','T','90','11',NULL,'Preference Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''T~'')','EPRUDAHCEXZ0','50','T','90','12',NULL,'Custom Characteristics Record Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalCoverageAmount"','13','(''UA''=''T~'')','EPRUDAHCEXZ0','50','T','90','13',NULL,'Total Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalRecordQuantity"','14','(''UA''=''T'')','EPRUDAHCEXZ0','50','T','90','14',NULL,'Total Record Quantity',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EPRUDAHCEX_20210812.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202108119','EMPEXPORT','OEACTIVE','Aug 12 2021  4:15AM','EPRUDAHCEX',NULL,NULL,NULL,'202108119','Aug 11 2021  5:31AM','Aug 11 2021  5:31AM','202108111','2','','','202108111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202108119','EMPEXPORT','OEPASSIVE','Aug 12 2021  4:15AM','EPRUDAHCEX',NULL,NULL,NULL,'202108119','Aug 11 2021  5:31AM','Aug 11 2021  5:31AM','202108111','582','','','202108111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Prudential AccHospCI Export','202108119','EMPEXPORT','ONDEM_XOE','Aug 12 2021  4:16AM','EPRUDAHCEX',NULL,NULL,NULL,'202108119','Aug 11 2021  5:31AM','Aug 11 2021  5:31AM','202108111','582','','','202108111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Prudential AccHospCI Exp-Sched','202108119','EMPEXPORT','SCH_EPRUDA','Aug 12 2021  4:19AM','EPRUDAHCEX',NULL,NULL,NULL,'202108119','Aug 11 2021  5:31AM','Aug 11 2021  5:31AM','202108111','582','','','202108111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Prudential AccHospCI Exp-Test','202108119','EMPEXPORT','TEST_XOE','Aug 12 2021  4:21AM','EPRUDAHCEX',NULL,NULL,NULL,'202108119','Aug 11 2021  5:31AM','Aug 11 2021  5:31AM','202108111','582','','','202108111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDAHCEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDAHCEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDAHCEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDAHCEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUDAHCEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EPRUDAHCEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EPRUDAHCEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EPRUDAHCEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPRUDAHCEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDAHCEX','H01','dbo.U_EPRUDAHCEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDAHCEX','D10','dbo.U_EPRUDAHCEX_drvTbl_Associate',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDAHCEX','D20','dbo.U_EPRUDAHCEX_drvTbl_EmploymentInfo',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDAHCEX','D30','dbo.U_EPRUDAHCEX_drvTbl_Coverage',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDAHCEX','D40','dbo.U_EPRUDAHCEX_drvTbl_Dependent',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUDAHCEX','T90','dbo.U_EPRUDAHCEX_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EPRUDAHCEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPRUDAHCEX] (
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
IF OBJECT_ID('U_EPRUDAHCEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_Associate') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_drvTbl_Associate] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(15) NULL,
    [drvAssociateId] char(9) NULL,
    [drvAssociateSSN] char(11) NULL,
    [drvAssociateGenderCode] varchar(7) NOT NULL,
    [drvAssociateDateOfBirth] datetime NULL,
    [drvAssociateSmokerStatus] varchar(10) NOT NULL,
    [drvAssociateMartialStatus] varchar(8) NOT NULL,
    [drvAssociateSuffix] varchar(30) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAssociatePhone1] varchar(50) NULL
);
IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_Coverage') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_drvTbl_Coverage] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(15) NULL,
    [drvAssociateId] char(9) NULL,
    [drvProductCode] varchar(4) NULL,
    [drvCoverageTierCode] varchar(2) NULL,
    [drvProductPlanCode] varchar(4) NULL,
    [drvCoverageAmount] nvarchar(4000) NULL,
    [drvCoverageEffectiveDate] datetime NULL,
    [drvCoverageEndDate] datetime NULL,
    [drvCoverageStatusCode] varchar(10) NOT NULL,
    [drvCoverageStatusEffDate] datetime NULL,
    [drvVoluntaryBasis] varchar(9) NULL
);
IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_Dependent') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_drvTbl_Dependent] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(44) NULL,
    [drvAssociateId] char(9) NULL,
    [drvDependentId] bigint NULL,
    [drvDependentRelationship] varchar(16) NULL,
    [drvDependentSSN] char(11) NULL,
    [drvDependentGenderCode] varchar(7) NOT NULL,
    [drvDependentDateOfBirth] datetime NULL,
    [drvDependentDateOfDeath] datetime NULL,
    [drvDependentSmokerStatus] varchar(10) NOT NULL,
    [drvDependentSuffix] varchar(30) NULL,
    [drvDependentNameFirst] varchar(100) NULL,
    [drvDependentNameLast] varchar(100) NULL,
    [drvDependentNameMiddle] varchar(50) NULL,
    [drvDependentAddressLine1] varchar(255) NULL,
    [drvDependentAddressLine2] varchar(255) NULL,
    [drvDependentAddressCity] varchar(255) NULL,
    [drvDependentAddressState] varchar(255) NULL,
    [drvDependentAddressZipCode] varchar(50) NULL,
    [drvIncapacitateDepCertInd] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_EmploymentInfo') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_drvTbl_EmploymentInfo] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(15) NULL,
    [drvAssociateId] char(9) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvRetirementDate] datetime NULL,
    [drvEmpTerminationDate] datetime NULL,
    [drvEmpTerminationReason] varchar(10) NULL,
    [drvEmploymentStatusCode] varchar(16) NOT NULL,
    [drvEmploymentStatusEffDate] datetime NULL,
    [drvMemberGroupCode] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EPRUDAHCEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EPRUDAHCEX_File') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EPRUDAHCEX_Header') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_Header] (
    [drvCreationDateTime] varchar(8000) NULL,
    [drvTestProductionCode] varchar(10) NOT NULL,
    [drvActivityStartDateTime] varchar(8000) NULL,
    [drvActivityEndDateTime] varchar(8000) NULL
);
IF OBJECT_ID('U_EPRUDAHCEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_EPRUDAHCEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_PEarHist] (
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
IF OBJECT_ID('U_EPRUDAHCEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_EPRUDAHCEX_Trailer] (
    [drvAuditId] varchar(8) NULL,
    [drvAssociateRecordQuantity] nvarchar(4000) NULL,
    [drvCoverageRecordQuantity] nvarchar(4000) NULL,
    [drvDependentRecordQuantity] nvarchar(4000) NULL,
    [drvEmployeeInfoRecordQuantity] nvarchar(4000) NULL,
    [drvTotalCoverageAmount] money NULL,
    [drvTotalRecordQuantity] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUDAHCEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Becker & Poliakoff

Created By: James Bender
Business Analyst: Lea King
Create Date: 08/11/2021
Service Request Number: TekP-2021-07-07-0001

Purpose: Prudential AccHospCI Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUDAHCEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUDAHCEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUDAHCEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRUDAHCEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUDAHCEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDAHCEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDAHCEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDAHCEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDAHCEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUDAHCEX', 'SCH_EPRUDA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRUDAHCEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRUDAHCEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPRUDAHCEX';

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
    DELETE FROM dbo.U_EPRUDAHCEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRUDAHCEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACIN2,CRIL2,CRLC2,CRLS2,HOSP2,ACIN1,CRIL1,CRLC1,CRLS1,HOSP1';

    IF OBJECT_ID('U_EPRUDAHCEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDAHCEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRUDAHCEX_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPRUDAHCEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDAHCEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EPRUDAHCEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRUDAHCEX_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EPRUDAHCEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDAHCEX_PEarHist;
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
    INTO dbo.U_EPRUDAHCEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDAHCEX_drvTbl_Associate
    ---------------------------------
    IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_Associate','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDAHCEX_drvTbl_Associate;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN + ' 1  '
        -- standard fields above and additional driver fields below
        ,drvAssociateId = EecEmpNo
        ,drvAssociateSSN = eepSSN
        ,drvAssociateGenderCode =    CASE WHEN EepGender = 'F' THEN 'FEMALE'
                                        WHEN EepGender = 'M' THEN 'MALE'
                                        ELSE 'UNKNOWN'
                                    END
        ,drvAssociateDateOfBirth = EepDateOfBirth
        ,drvAssociateSmokerStatus =    CASE WHEN EepIsSmoker = 'Y' THEN 'SMOKER'
                                        WHEN EepIsSmoker = 'N' THEN 'NON SMOKER'
                                        ELSE 'UNKNOWN'
                                    END
        ,drvAssociateMartialStatus =    CASE WHEN EepMaritalStatus = 'S' THEN 'SINGLE'
                                            WHEN EepMaritalStatus = 'M' THEN 'MARRIED'
                                            WHEN EepMaritalStatus = 'D' THEN 'DIVORCED'
                                            WHEN EepMaritalStatus = 'W' THEN 'WIDOWED'
                                            ELSE 'UNKNOWN'
                                        END
        ,drvAssociateSuffix = EepNameSuffix
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAssociatePhone1 = EfoPhoneNumber
    INTO dbo.U_EPRUDAHCEX_drvTbl_Associate
    FROM dbo.U_EPRUDAHCEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EPRUDAHCEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.EmpMPhon 
        ON EfoEEID = xEEID
        AND EfoPhoneType = 'CEL'
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDAHCEX_drvTbl_EmploymentInfo
    ---------------------------------
    IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_EmploymentInfo','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDAHCEX_drvTbl_EmploymentInfo;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN + ' 2  '
        -- standard fields above and additional driver fields below
        ,drvAssociateId = EecEmpNo
        ,drvEmployeeID = EecEmpNo
        ,drvHireDate = EecDateOfBenefitSeniority
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvRetirementDate = CASE WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','RET') THEN EecDateOfTermination END
        ,drvEmpTerminationDate = EecDateOfTermination
        ,drvEmpTerminationReason =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202','RET') THEN 'RETIRED'
                                        WHEN  EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DECEASED'
                                        WHEN  EecEmplStatus = 'T' ANd EecTermReason NOT IN ('202','RET','203') THEN 'TERMINATED'
                                    END
        ,drvEmploymentStatusCode =    CASE WHEN  EecEmplStatus = 'T' AND  EecTermReason IN ('202','RET') THEN 'RETIRED'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DECEASED'
                                        WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN  ('202','RET','203') THEN 'TERMINATED'
                                        WHEN EecEmplStatus = 'L' THEN 'LEAVE OF ABSENCE'
                                        ELSE 'ACTIVE'
                                    END
        ,drvEmploymentStatusEffDate = EecEmplStatusStartDate
        ,drvMemberGroupCode = CASE WHEN EecDedGroupCode = 'ATTY' THEN '002' ELSE '001' END
    INTO dbo.U_EPRUDAHCEX_drvTbl_EmploymentInfo
    FROM dbo.U_EPRUDAHCEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPRUDAHCEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDAHCEX_drvTbl_Coverage
    ---------------------------------
    IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_Coverage','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDAHCEX_drvTbl_Coverage;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN + ' 3  '
        -- standard fields above and additional driver fields below
        ,drvAssociateId = EecEmpNo
        ,drvProductCode =    CASE WHEN BdmDedCode IN('CRIL1','CRIL2','CRLC1','CRLC2','CRLS1','CRLS2') THEN 'VCI'
                                WHEN BdmDedCode IN ('ACIN1','ACIN2') THEN 'VACC'
                                WHEN Bdmdedcode IN ('HOSP1','HOSP2') THEN 'VHIP'
                            END
        ,drvCoverageTierCode =    CASE WHEN BdmDedCode IN ('CRIL1','CRIL2') THEN 'EE' 
                                    WHEN BdmDedCode IN ('CRLS1','CRLS2')  THEN 'SP'
                                    WHEN BdmDedCode IN ('CRLC1','CRLC2') THEN 'CH'
                                    WHEN BdmDedCode IN ('ACIN1','ACIN2','HOSP1','HOSP2') AND BdmBenOption = 'EE' THEN 'EE'
                                    WHEN BdmDedCode IN ('ACIN1','ACIN2','HOSP1','HOSP2') AND BdmBenOption = 'ES' THEN 'ES'
                                    WHEN BdmDedCode IN ('ACIN1','ACIN2','HOSP1','HOSP2') AND BdmBenOption = 'EC' THEN 'EC'
                                    WHEN BdmDedCode IN ('ACIN1','ACIN2','HOSP1','HOSP2') AND BdmBenOption = 'EF' THEN 'FM'
                                END
        ,drvProductPlanCode =    CASE WHEN BdmDedCode IN('CRIL1','CRIL2','CRLC1','CRLC2','CRLS1','CRLS2') THEN '4982'
                                    WHEN BdmDedCode IN ('ACIN1','ACIN2') THEN '4981'
                                    WHEN Bdmdedcode IN ('HOSP1','HOSP2') THEN '4984'
                                END
        ,drvCoverageAmount = FORMAT(CASE WHEN BdmDedCode IN ('CRIL1','CRIL2','CRLC1','CRLC2','CRLS1','CRLS2') THEN BdmEEAmt END, '#0.00')
        ,drvCoverageEffectiveDate = BdmBenStartDate
        ,drvCoverageEndDate = BdmBenStopDate
        ,drvCoverageStatusCode = CASE WHEN BdmBenStatus IN ('T','C') THEN 'TERMINATED' ELSE 'ACTIVE' END
        ,drvCoverageStatusEffDate = BdmBenStartDate
        ,drvVoluntaryBasis = CASE WHEN BdmDedCode IN ('ACIN1','ACIN2') THEN 'TREATMENT' END
    INTO dbo.U_EPRUDAHCEX_drvTbl_Coverage
    FROM dbo.U_EPRUDAHCEX_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EPRUDAHCEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPRUDAHCEX_drvTbl_Dependent
    ---------------------------------
    IF OBJECT_ID('U_EPRUDAHCEX_drvTbl_Dependent','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDAHCEX_drvTbl_Dependent;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN + ' 4' + ' ' + CAST(ConDepNo AS VARCHAR)
        -- standard fields above and additional driver fields below
        ,drvAssociateId = EecEmpNo
        ,drvDependentId = ConDepNo
        ,drvDependentRelationship =    CASE WHEN ConRelationship IN ('DP') THEN 'DOMESTIC PARTNER'
                                        WHEN ConRelationship IN ('SPS') THEN 'SPOUSE'
                                        WHEN ConRelationship IN ('ACH','CHL','STC') THEN 'CHILD'
                                    END
        ,drvDependentSSN = ConSSN
        ,drvDependentGenderCode =    CASE WHEN ConGender = 'F' THEN 'FEMALE'
                                        WHEN ConGender = 'M' THEN 'MALE'
                                        ELSE 'UNKNOWN'
                                    END
        ,drvDependentDateOfBirth = ConDateOfBirth
        ,drvDependentDateOfDeath = ConDeathDate
        ,drvDependentSmokerStatus = CASE WHEN ConIsSmoker = 'Y' THEN 'SMOKER'
                                        WHEN ConIsSmoker = 'N' THEN 'NON SMOKER'
                                        ELSE 'UNKNOWN'
                                    END
        ,drvDependentSuffix = CASE WHEN ConNameSuffix <> 'Z' THEN ConNameSuffix END
        ,drvDependentNameFirst = ConNameFirst
        ,drvDependentNameLast = ConNameLast
        ,drvDependentNameMiddle = ConNameMiddle
        ,drvDependentAddressLine1 = ConAddressLine1
        ,drvDependentAddressLine2 = ConAddressLine2
        ,drvDependentAddressCity = ConAddressCity
        ,drvDependentAddressState = ConAddressState
        ,drvDependentAddressZipCode = ConAddressZipCode
        ,drvIncapacitateDepCertInd = CASE WHEN ConIsDisabled = 'Y' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EPRUDAHCEX_drvTbl_Dependent
    FROM dbo.U_EPRUDAHCEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EPRUDAHCEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN (
            SELECT DISTINCT ConEEID
                ,ConSystemID
                ,ConNameFirst
                ,ConNameMiddle
                ,ConNameLast
                ,ConRelationship
                ,ConSSN
                ,ConAddressLine1
                ,ConAddressLIne2
                ,ConAddressCity
                ,ConAddressState
                ,ConAddressZipCode
                ,ConGender 
                ,ConDateOfBirth 
                ,ConDeathDate
                ,ConIsSmoker
                ,ConNameSuffix
                ,ConIsDisabled
                ,ConDepNo = ROW_NUMBER() OVER (PARTITION BY RTRIM(ConEEID) ORDER BY conDateOfBirth ASC) + 1
              FROM dbo.Contacts WITH (NOLOCK)
              JOIN (
                        SELECT DISTINCT BdmEEID, BdmDepRecID
                        FROM dbo.U_dsi_BDM_EPRUDAHCEX WITH (NOLOCK)) AS SpsChld
                ON ConEEID = BdmEEID
                AND ConSystemID = BdmDepRecId
             WHERE ConRelationship IN ('CH','CHL','DPC','STC')             
            UNION
            SELECT DISTINCT ConEEID
                ,ConSystemID
                ,ConNameFirst
                ,ConNameMiddle
                ,ConNameLast
                ,ConRelationship
                ,ConSSN
                ,ConAddressLine1
                ,ConAddressLIne2
                ,ConAddressCity
                ,ConAddressState
                ,ConAddressZipCode
                ,ConGender 
                ,ConDateOfBirth 
                ,ConDeathDate
                ,ConIsSmoker
                ,ConNameSuffix
                ,ConIsDisabled
                ,ConDepNo = 1
              FROM dbo.Contacts WITH (NOLOCK)
              JOIN (
                        SELECT DISTINCT BdmEEID, BdmDepRecID
                        FROM dbo.U_dsi_BDM_EPRUDAHCEX WITH (NOLOCK)) AS BdmChld
                ON ConEEID = BdmEEID
                AND ConSystemID = BdmDepRecId
             WHERE ConRelationship IN ('SPS','DP')) AS Con
            ON ConEEID = xEEID
            AND ConSystemID = BdmDepRecID
        WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN DATEADD(DAY, -30, @EndDate) AND @EndDate)
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPRUDAHCEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDAHCEX_Header;
    SELECT DISTINCT
         drvCreationDateTime = REPLACE(CONVERT(VARCHAR(8), GETDATE(), 112) + CONVERT(VARCHAR(8), GETDATE(), 108), ':', '')
        ,drvTestProductionCode = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'Test' ELSE 'Production' END
        ,drvActivityStartDateTime = REPLACE(CONVERT(VARCHAR(8), DATEADD(DAY, -6, GETDATE()), 112) + CONVERT(VARCHAR(8), DATEADD(DAY, -6, GETDATE()), 108), ':', '')
        ,drvActivityEndDateTime = REPLACE(CONVERT(VARCHAR(8), GETDATE(), 112) + CONVERT(VARCHAR(8), GETDATE(), 108), ':', '')
    INTO dbo.U_EPRUDAHCEX_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPRUDAHCEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUDAHCEX_Trailer;
    SELECT DISTINCT
         drvAuditId = CONVERT(VARCHAR(8), GETDATE(), 112)
        ,drvAssociateRecordQuantity = FORMAT((SELECT COUNT(*) FROM dbo.U_EPRUDAHCEX_drvTbl_Associate), '#0')
        ,drvCoverageRecordQuantity = FORMAT((SELECT COUNT(*) FROM dbo.U_EPRUDAHCEX_drvTbl_Coverage), '#0')
        ,drvDependentRecordQuantity = FORMAT((SELECT COUNT(*) FROM dbo.U_EPRUDAHCEX_drvTbl_Dependent), '#0')
        ,drvEmployeeInfoRecordQuantity = FORMAT((SELECT COUNT(*) FROM dbo.U_EPRUDAHCEX_drvTbl_EmploymentInfo), '#0')
        ,drvTotalCoverageAmount = (SELECT SUM(CAST(drvCoverageAmount AS MONEY)) FROM dbo.U_EPRUDAHCEX_drvTbl_Coverage)
        ,drvTotalRecordQuantity = FORMAT(
                                            (SELECT COUNT(*) FROM dbo.U_EPRUDAHCEX_drvTbl_Associate)
                                            + (SELECT COUNT(*) FROM dbo.U_EPRUDAHCEX_drvTbl_Coverage)
                                            + (SELECT COUNT(*) FROM dbo.U_EPRUDAHCEX_drvTbl_Dependent)
                                            + (SELECT COUNT(*) FROM dbo.U_EPRUDAHCEX_drvTbl_EmploymentInfo)
                                    , '#0')
    INTO dbo.U_EPRUDAHCEX_Trailer
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
ALTER VIEW dbo.dsi_vwEPRUDAHCEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPRUDAHCEX_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;
    --ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPRUDAHCEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108041'
       ,expStartPerControl     = '202108041'
       ,expLastEndPerControl   = '202108119'
       ,expEndPerControl       = '202108119'
WHERE expFormatCode = 'EPRUDAHCEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPRUDAHCEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPRUDAHCEX_File (NOLOCK)
    ORDER BY  CASE WHEN LEFT(RecordSet, 1) = 'H' THEN '000000000' ELSE InitialSort END, SubSort;