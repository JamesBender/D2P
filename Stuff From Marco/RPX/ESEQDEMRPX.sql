SET NOCOUNT ON;
IF OBJECT_ID('U_ESEQDEMRPX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESEQDEMRPX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESEQDEMRPX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESEQDEMRPX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESEQDEMRPX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESEQDEMRPX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEQDEMRPX];
GO
IF OBJECT_ID('U_ESEQDEMRPX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_PEarHist];
GO
IF OBJECT_ID('U_ESEQDEMRPX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_PDedHist];
GO
IF OBJECT_ID('U_ESEQDEMRPX_File') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_File];
GO
IF OBJECT_ID('U_ESEQDEMRPX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_EEList];
GO
IF OBJECT_ID('U_ESEQDEMRPX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_drvTbl];
GO
IF OBJECT_ID('U_ESEQDEMRPX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_DedList];
GO
IF OBJECT_ID('U_ESEQDEMRPX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_AuditFields];
GO
IF OBJECT_ID('U_ESEQDEMRPX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESEQDEMRPX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESEQDEMRPX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESEQDEMRPX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESEQDEMRPX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESEQDEMRPX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESEQDEMRPX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESEQDEMRPX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESEQDEMRPX','Sequoia Demographics Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ESEQDEMRPXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESEQDEMRPX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COMPANY NAME"','1','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','1',NULL,'COMPANY NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE ID"','2','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','2',NULL,'EMPLOYEE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE SSN"','3','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','3',NULL,'EMPLOYEE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MEMBER SSN"','4','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','4',NULL,'MEMBER SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NEW MEMBER SSN"','5','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','5',NULL,'NEW MEMBER SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN CHANGE TYPE"','6','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','6',NULL,'SSN CHANGE TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRST NAME"','7','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','7',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LAST NAME"','8','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','8',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE NAME"','9','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','9',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','10','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','10',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RELATIONSHIP"','11','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','11',NULL,'RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','12','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','12',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MARITAL STATUS"','13','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','13',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE STATUS"','14','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','14',NULL,'EMPLOYEE STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE STATUS DATE"','15','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','15',NULL,'EMPLOYEE STATUS DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIRE DATE"','16','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','16',NULL,'HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STREET ADDRESS1"','17','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','17',NULL,'STREET ADDRESS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STREET ADDRESS2"','18','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','18',NULL,'STREET ADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','19','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','19',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STATE"','20','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','20',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP"','21','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','21',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOME PHONE"','22','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','22',NULL,'HOME PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CELL PHONE"','23','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','23',NULL,'CELL PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WORK PHONE"','24','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','24',NULL,'WORK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WORK EMAIL"','25','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','25',NULL,'WORK EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"JOB TITLE"','26','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','26',NULL,'JOB TITLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOCATION"','27','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','27',NULL,'EMPLOYEE LOCATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE LOCATION EFFECTIVE DATE"','28','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','28',NULL,'EMPLOYEE LOCATION EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE CLASS"','29','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','29',NULL,'EMPLOYEE CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE CLASS EFFECTIVE DATE"','30','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','30',NULL,'EMPLOYEE CLASS EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE DEPARTMENT"','31','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','31',NULL,'EMPLOYEE DEPARTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE DEPARTMENT EFFECTIVE DATE"','32','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','32',NULL,'EMPLOYEE DEPARTMENT EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE DIVISION"','33','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','33',NULL,'EMPLOYEE DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE DIVISION EFFECTIVE DATE"','34','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','34',NULL,'EMPLOYEE DIVISION EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PAY FREQUENCY"','35','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','35',NULL,'PAY FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOURS PER WEEK"','36','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','36',NULL,'HOURS PER WEEK',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ANNUAL WAGES"','37','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','37',NULL,'ANNUAL WAGES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WAGES EFFECTIVE DATE"','38','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','38',NULL,'WAGES EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"APPLICATION PERSON ID"','39','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','39',NULL,'APPLICATION PERSON ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN YEAR"','40','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','40',NULL,'PLAN YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN TYPE"','41','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','41',NULL,'PLAN TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN GROUP NUMBER"','42','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','42',NULL,'PLAN GROUP NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CLASS CODE"','43','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','43',NULL,'CLASS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT STATUS"','44','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','44',NULL,'ENROLLMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT START DATE"','45','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','45',NULL,'ENROLLMENT START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT END DATE"','46','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','46',NULL,'ENROLLMENT END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ORIGINAL ENROLLMENT START DATE"','47','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','47',NULL,'ORIGINAL ENROLLMENT START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"APPROVED AMOUNT"','48','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','48',NULL,'APPROVED AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REQUESTED AMOUNT"','49','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','49',NULL,'REQUESTED AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ENROLLMENT TYPE"','50','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','50',NULL,'ENROLLMENT TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVERAGE DESCRIPTION"','51','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','H','01','51',NULL,'COVERAGE DESCRIPTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVERAGE TIER"','52','(''DA''=''Q'')','ESEQDEMRPXZ0','50','H','01','52',NULL,'COVERAGE TIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RPX"','1','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','1',NULL,'COMPANY NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','2','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','2',NULL,'EMPLOYEE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','3',NULL,'EMPLOYEE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberSSN"','4','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','4',NULL,'MEMBER SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','5',NULL,'NEW MEMBER SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','6',NULL,'SSN CHANGE TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','7',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','8',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','9',NULL,'MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','10','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','10',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','11','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','11',NULL,'RELATIONSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','12',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','13','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','13',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','14','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','14',NULL,'EMPLOYEE STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusDate"','15','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','15',NULL,'EMPLOYEE STATUS DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','16','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','16',NULL,'HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','17','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','17',NULL,'STREET ADDRESS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','18','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','18',NULL,'STREET ADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','19','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','19',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','20','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','20',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','21','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','21',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','22','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','22',NULL,'HOME PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','23',NULL,'CELL PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','24',NULL,'WORK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmail"','25','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','25',NULL,'WORK EMAIL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','26','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','26',NULL,'JOB TITLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLocation"','27','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','27',NULL,'EMPLOYEE LOCATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLocationEffDate"','28','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','28',NULL,'EMPLOYEE LOCATION EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeClass"','29','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','29',NULL,'EMPLOYEE CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeClassEffDate"','30','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','30',NULL,'EMPLOYEE CLASS EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDepartment"','31','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','31',NULL,'EMPLOYEE DEPARTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDepartmentEffDate"','32','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','32',NULL,'EMPLOYEE DEPARTMENT EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDivision"','33','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','33',NULL,'EMPLOYEE DIVISION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDivisionEffectiveDate"','34','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','34',NULL,'EMPLOYEE DIVISION EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','35','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','35',NULL,'PAY FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerWeek"','36','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','36',NULL,'HOURS PER WEEK',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualWages"','37','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','37',NULL,'ANNUAL WAGES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWagesEffectiveDate"','38','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','38',NULL,'WAGES EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','39',NULL,'APPLICATION PERSON ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYear"','40','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','40',NULL,'PLAN YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','41','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','41',NULL,'PLAN TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanGroupNumber"','42','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','42',NULL,'PLAN GROUP NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassCode"','43','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','43',NULL,'CLASS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus"','44','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','44',NULL,'ENROLLMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStartDate"','45','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','45',NULL,'ENROLLMENT START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentEndDate"','46','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','46',NULL,'ENROLLMENT END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalEnrollmentDate"','47','(''UD101''=''Q,'')','ESEQDEMRPXZ0','50','D','10','47',NULL,'ORIGINAL ENROLLMENT START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApprovedAmount"','48','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','48',NULL,'APPROVED AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRequestedAmount"','49','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','49',NULL,'REQUESTED AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentType"','50','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','50',NULL,'ENROLLMENT TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverateDesc"','51','(''UA''=''Q,'')','ESEQDEMRPXZ0','50','D','10','51',NULL,'COVERAGE DESCRIPTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','52','(''UA''=''Q'')','ESEQDEMRPXZ0','50','D','10','52',NULL,'COVERAGE TIER',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESEQDEMRPX_20210312.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202011129','EMPEXPORT','OEACTIVE',NULL,'ESEQDEMRPX',NULL,NULL,NULL,'202011129','Nov 12 2020  2:08PM','Nov 12 2020  2:08PM','202011121',NULL,'','','202011121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202011129','EMPEXPORT','OEPASSIVE',NULL,'ESEQDEMRPX',NULL,NULL,NULL,'202011129','Nov 12 2020  2:08PM','Nov 12 2020  2:08PM','202011121',NULL,'','','202011121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sequoia Demographics Export','202011129','EMPEXPORT','ONDEM_XOE',NULL,'ESEQDEMRPX',NULL,NULL,NULL,'202011129','Nov 12 2020  2:08PM','Nov 12 2020  2:08PM','202011121',NULL,'','','202011121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',EZQDT,F1N78,H3NE9,NSEGA,F1NC2,CH10X,F1NG7,F1NDT,LNA6Q,F1NHS,CH0YK,CH0VR,LNAAL,LNA83,6TWV9,F1N9L,F1NM1,B2S45,C80WA',NULL,NULL,NULL,'Sequoia Demographics Exp-Sched','202011129','EMPEXPORT','SCH_ESEQDE',NULL,'ESEQDEMRPX',NULL,NULL,NULL,'202102059','Nov 12 2020  2:08PM','Nov 12 2020  2:08PM','202101291',NULL,'','','202011121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Sequoia Demographics Exp-Test','202103119','EMPEXPORT','TEST_XOE','Mar 11 2021  1:10PM','ESEQDEMRPX',NULL,NULL,NULL,'202103119','Mar 11 2021 12:00AM','Dec 30 1899 12:00AM','202101011','1248','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3lKiRPX1000',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESEQDEMRPX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESEQDEMRPX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESEQDEMRPX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESEQDEMRPX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESEQDEMRPX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEQDEMRPX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESEQDEMRPX','D10','dbo.U_ESEQDEMRPX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESEQDEMRPX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESEQDEMRPX] (
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
IF OBJECT_ID('U_ESEQDEMRPX_Audit') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_Audit] (
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
IF OBJECT_ID('U_ESEQDEMRPX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ESEQDEMRPX_DedList') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESEQDEMRPX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvSSN] char(11) NULL,
    [drvMemberSSN] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvRelationship] varchar(22) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvEmployeeStatus] varchar(10) NULL,
    [drvEmployeeStatusDate] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvJobTitle] varchar(25) NULL,
    [drvEmployeeLocation] varchar(25) NULL,
    [drvEmployeeLocationEffDate] datetime NULL,
    [drvEmployeeClass] varchar(7) NULL,
    [drvEmployeeClassEffDate] datetime NULL,
    [drvEmployeeDivision] varchar(10) NULL,
    [drvEmployeeDivisionEffectiveDate] datetime NULL,
    [drvEmployeeDepartment] varchar(10) NULL,
    [drvEmployeeDepartmentEffDate] datetime NULL,
    [drvPayFrequency] char(1) NULL,
    [drvHoursPerWeek] nvarchar(4000) NULL,
    [drvAnnualWages] nvarchar(4000) NULL,
    [drvWagesEffectiveDate] datetime NULL,
    [drvPlanYear] varchar(30) NULL,
    [drvPlanType] varchar(3) NULL,
    [drvPlanGroupNumber] varchar(9) NULL,
    [drvClassCode] varchar(1) NOT NULL,
    [drvEnrollmentStatus] varchar(10) NOT NULL,
    [drvEnrollmentStartDate] datetime NULL,
    [drvEnrollmentEndDate] datetime NULL,
    [drvOriginalEnrollmentDate] datetime NULL,
    [drvApprovedAmount] nvarchar(4000) NULL,
    [drvRequestedAmount] nvarchar(4000) NULL,
    [drvEnrollmentType] varchar(1) NULL,
    [drvCoverateDesc] varchar(5) NULL,
    [drvCoverageTier] varchar(3) NULL
);
IF OBJECT_ID('U_ESEQDEMRPX_EEList') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESEQDEMRPX_File') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ESEQDEMRPX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_PDedHist] (
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
IF OBJECT_ID('U_ESEQDEMRPX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESEQDEMRPX_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESEQDEMRPX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: RPX Corporation

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 03/05/2021
Service Request Number: TekP-2020-11-09-0001

Purpose: Sequoia Demographics Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESEQDEMRPX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESEQDEMRPX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESEQDEMRPX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESEQDEMRPX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESEQDEMRPX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESEQDEMRPX', 'SCH_ESEQDE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESEQDEMRPX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESEQDEMRPX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESEQDEMRPX';

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
    DELETE FROM dbo.U_ESEQDEMRPX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESEQDEMRPX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ESEQDEMRPX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID  FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'RPXAT,RPXHS,RPXHM,RPXGD,MKHMO,SLTDB,LIFEE,SSLFE,SCLFE,ELIFE,SADD,SSTD,SLTD,SSTDB,VIS,VISBU';
    --SET @DedList = 'APPO1,APPO2,DPMED,AHMO1,AHMO2,DPMED,EPO1,EPO2,DPMED,KHMO1,KHMO2,DPMED,ADEN1,ADEN2,DPDEN,DENP1,DENP2,DPDEN,VSNPR ,DPVIS,LIFER,BADD,VLP,VLEG,ADDEE,ADDEG,VLPSP,ADDSP,VLDEP,ADDCH,LTDER,STDER';

    IF OBJECT_ID('U_ESEQDEMRPX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESEQDEMRPX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESEQDEMRPX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_AuditFields;
    CREATE TABLE dbo.U_ESEQDEMRPX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ESEQDEMRPX_AuditFields VALUES ('EmpComp','EecLocation');
    INSERT INTO dbo.U_ESEQDEMRPX_AuditFields VALUES ('EmpComp','EecDedGroupCode');
    INSERT INTO dbo.U_ESEQDEMRPX_AuditFields VALUES ('EmpComp','eecOrglvl2');
    INSERT INTO dbo.U_ESEQDEMRPX_AuditFields VALUES ('EmpComp','eecOrglvl1');

    

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESEQDEMRPX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_Audit;
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
--        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ESEQDEMRPX_Audit
    FROM dbo.U_ESEQDEMRPX_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ESEQDEMRPX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE --audDateTime BETWEEN @StartDate AND @EndDate
    --AND audAction <> 'DELETE'
    --AND 
    ISNULL(audNewValue,'') <> '';
    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_ESEQDEMRPX_Audit WHERE audRowNo > 1;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@EndDate -30);
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

    
    DELETE dbo.U_dsi_BDM_ESEQDEMRPX 
    where BdmDedCode IN ('VLP','VLEG','ADDEE','ADDEG') AND BdmRecType <> 'EMP'

    
    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ESEQDEMRPX D
    JOIN dbo.U_dsi_bdm_ESEQDEMRPX E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ESEQDEMRPX
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ESEQDEMRPX
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ESEQDEMRPX
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ESEQDEMRPX
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ESEQDEMRPX
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ESEQDEMRPX
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESEQDEMRPX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_PDedHist;
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
    INTO dbo.U_ESEQDEMRPX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESEQDEMRPX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESEQDEMRPX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_PEarHist;
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
    INTO dbo.U_ESEQDEMRPX_PEarHist
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
    -- DETAIL RECORD - U_ESEQDEMRPX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESEQDEMRPX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESEQDEMRPX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),bdmdeprecid) --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvSSN = eepSSN
        ,drvMemberSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvRelationship =    CASE WHEN BdmRecType = 'EMP' THEN 'Employee'
                                ELSE
                                    CASE WHEN ConRelationship IN ('SPS','DPR') THEN 'Spouse'
                                        WHEN ConRelationship = 'DP' THEN 'Domestic Partner'
                                        WHEN ConRelationship IN ('CHL','STC','CHD') THEN 'Child'
                                        WHEN ConRelationship = 'DPC' THEN 'Domestic Partner Child'
                                    END
                            END
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvMaritalStatus = CASE WHEN  eepMaritalStatus = 'S' THEN 'I'
                                 WHEN  eepMaritalStatus = 'C' THEN 'B'
                                 WHEN eepMaritalStatus in ('','Z')  THEN 'R'
                                 WHEN eepMaritalStatus = 'P' THEN 'S'
                                 ELSE  eepMaritalStatus
                            END
        ,drvEmployeeStatus =    CASE WHEN EecEmplStatus = 'T'  and eectermreason = '203' THEN 'Deceased'
                                     WHEN EecEmplStatus = 'T'  and eectermreason <> '203' THEN 'Terminated'
                                    WHEN EecEmplStatus = 'L' THEN 'L1'
                                    WHEN EecFullTimeOrPartTime = 'P' THEN 'PT'
                                    WHEN EecFullTimeOrPartTime = 'F' THEN 'FT'
                                END
        ,drvEmployeeStatusDate = CASE WHEN BdmRecType = 'EMP' and EecEmplStatus = 'T' THEN eecdateoftermination ELSE EecEmplStatusStartDate END
        ,drvHireDate = CASE WHEN BdmRecType = 'EMP' THEN EecDateOfLastHire END
        ,drvAddressLine1 = eepAddressLine1 
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvHomePhone = ''
        ,drvWorkEmail = CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail END
        ,drvJobTitle = CASE WHEN BdmRecType = 'EMP' THEN JbcDesc END
        ,drvEmployeeLocation = CASE WHEN BdmRecType = 'EMP' THEN LocDesc END
        ,drvEmployeeLocationEffDate = CASE WHEN BdmRecType = 'EMP' THEN (Select top 1  audDateTime from dbo.U_ESEQDEMRPX_Audit where AudEeid = xeeid and AudFieldName = 'EecLocation') END
        ,drvEmployeeClass =   CASE WHEN EecDedGroupCode <> 'NONE' THEN 'Regular' END
        ,drvEmployeeClassEffDate = CASE WHEN BdmRecType = 'EMP' THEN (Select top 1  audDateTime from dbo.U_ESEQDEMRPX_Audit where AudEeid = xeeid and AudFieldName = 'EecDedGroupCode') END
        ,drvEmployeeDivision = CASE WHEN BdmRecType = 'EMP' THEN eecOrglvl1 END
        ,drvEmployeeDivisionEffectiveDate = CASE WHEN BdmRecType = 'EMP' THEN (Select top 1  audDateTime from dbo.U_ESEQDEMRPX_Audit where AudEeid = xeeid and AudFieldName = 'eecOrglvl1') END
        ,drvEmployeeDepartment = CASE WHEN BdmRecType = 'EMP' THEN eecOrglvl2 END
        ,drvEmployeeDepartmentEffDate = CASE WHEN BdmRecType = 'EMP' THEN (Select top 1  audDateTime from dbo.U_ESEQDEMRPX_Audit where AudEeid = xeeid and AudFieldName = 'eecOrglvl2') END
        ,drvPayFrequency = CASE WHEN BdmRecType = 'EMP' THEN PgrPayFrequency END
        ,drvHoursPerWeek = CASE WHEN BdmRecType = 'EMP' THEN FORMAT( (EecScheduledWorkHrs * 24 ) / 52, '#0.00') END
        ,drvAnnualWages = CASE WHEN BdmRecType = 'EMP' THEN FORMAT(EecAnnSalary, '#0.00') END
        ,drvWagesEffectiveDate = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GetDATE(), eecDateOfLastHire) END
        ,drvPlanYear = CAST( CASE WHEN YEAR(BdmBenStartDAte) < 2021 THEN '2021' ELSE  YEAR(BdmBenStartDAte) END as varchar) -- FORMAT(DATEPART(YEAR, BdmBenStartDate), '0000')
        ,drvPlanType =    CASE  WHEN Bdmdedcode = 'RPXAT' THEN 'PPO'
                                WHEN Bdmdedcode = 'RPXHS' THEN 'HSA'
                                WHEN Bdmdedcode = 'RPXHM' THEN 'HMO'
                                WHEN Bdmdedcode = 'RPXGD' THEN 'DEN'
                                WHEN Bdmdedcode = 'MKHMO' THEN 'HMO'
                                WHEN Bdmdedcode = 'SLTDB' THEN 'LTD'
                                WHEN Bdmdedcode = 'LIFEE' THEN 'LM'
                                WHEN Bdmdedcode = 'SSLFE' THEN 'LS'
                                WHEN Bdmdedcode = 'SCLFE' THEN 'LC'
                                WHEN Bdmdedcode = 'ELIFE' THEN 'LIF'
                                WHEN Bdmdedcode = 'SADD' THEN 'AJ'
                                WHEN Bdmdedcode = 'SSTD' THEN 'STD'
                                WHEN Bdmdedcode = 'SLTD' THEN 'LTD'
                                WHEN Bdmdedcode = 'SSTDB' THEN 'STD'
                                WHEN Bdmdedcode = 'VIS' THEN 'VIS'
                                WHEN Bdmdedcode = 'VISBU' THEN 'VIS'
                        END
        ,drvPlanGroupNumber =    CASE   WHEN Bdmdedcode = 'RPXAT' THEN '117497'
                                        WHEN Bdmdedcode = 'RPXHS' THEN '117497'
                                        WHEN Bdmdedcode = 'RPXHM' THEN '117497'
                                        WHEN Bdmdedcode = 'RPXGD' THEN '00556372'
                                        WHEN Bdmdedcode = 'MKHMO' THEN '000603773'
                                        WHEN Bdmdedcode = 'SLTDB' THEN '160627'
                                        WHEN Bdmdedcode = 'LIFEE' THEN '160627'
                                        WHEN Bdmdedcode = 'SSLFE' THEN '160627'
                                        WHEN Bdmdedcode = 'SCLFE' THEN '160627'
                                        WHEN Bdmdedcode = 'ELIFE' THEN '160627'
                                        WHEN Bdmdedcode = 'SADD' THEN '160627'
                                        WHEN Bdmdedcode = 'SSTD' THEN '160627'
                                        WHEN Bdmdedcode = 'SLTD' THEN '160627'
                                        WHEN Bdmdedcode = 'SSTDB' THEN '160627'
                                        WHEN Bdmdedcode = 'VIS' THEN '30029593'
                                        WHEN Bdmdedcode = 'VISBU' THEN '30029593'
                                END
        ,drvClassCode = ''
        ,drvEnrollmentStatus =    --CASE WHEN BdmRecType = 'EMP' THEN
                                    CASE 
                                        WHEN BdmBenStatus IN ('C','T') THEN 'Terminated'
                                        WHEN BdmBenStatus = 'W' THEN 'Waived'
                                        ELSE 'Enrolled'
                                    END
                                --END
        ,drvEnrollmentStartDate = dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDAte, '1/1/2021') --'1/1/' + FORMAT(DATEPART(YEAR, GETDATE()), '0000') --2020' --BdmBenStartDate
        ,drvEnrollmentEndDate = BdmBenStopDate
        ,drvOriginalEnrollmentDate = dbo.dsi_fnGetMinMaxDates('MAX', BdmBenStartDAte, '1/1/2021')
        ,drvApprovedAmount = CASE WHEN BdmDedCode IN ('LIFEE', 'SSLFE', 'SCLFE') THEN FORMAT( cast(isnull( (Select max(bdmusgfield1) from dbo.U_dsi_BDM_ESEQDEMRPX A where A.bdmeeid =  xeeid and A.bdmdedcode = bdmdedcode),0) as money), '#0.00') END
        ,drvRequestedAmount = CASE WHEN BdmDedCode IN ('LIFEE', 'SSLFE', 'SCLFE') THEN FORMAT(isnull(amtDesiredAmt,0), '#0.00') END
        ,drvEnrollmentType = CASE WHEN BdmBenStatus = 'A' THEN 'A' END

        ,drvCoverateDesc =    CASE WHEN BdmDedCode IN ('RPXGD', 'SSTD', 'SLTD','VIS') THEN 'BASE'
                            WHEN BdmDedCode IN ('SLTDB', 'SSTDB' ,'VISBU' ) THEN 'BUYUP'
                            END
        ,drvCoverageTier =    CASE WHEN BdmBenOption = '1EE' THEN 'EMP' 
                                WHEN BdmBenOption IN ('2EES','3EEDP') THEN 'ESP'
                                WHEN BdmBenOption IN ('4EEC') THEN 'ECH'
                                WHEN BdmBenOption IN ('5EEF') THEN 'FAM'
                            END
    INTO dbo.U_ESEQDEMRPX_drvTbl
    FROM dbo.U_ESEQDEMRPX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_ESEQDEMRPX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT OrgCode AS OrgLvl1Code, OrgDesc AS OrgLvl1Desc
                FROM dbo.vw_int_OrgLevel WITH (NOLOCK)) AS Lvl1
        ON EecOrgLvl1 = OrgLvl1Code
    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhOrgLvl1
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhOrgLvl1, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EecJobCode 
        AND EjhOrgLvl1 = EecOrgLvl1
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN (
                    SELECT EedEEID AS amtEEID, EedCOID AS amtCOID, EedDedCode AS amtDedCode, EedEOIDesiredAmt AS amtDesiredAmt, EedBenAmt AS amtBenAmt
                    FROM (
                            SELECT EedEEID, EedCOID, EedDedCode, EedEOIDesiredAmt, EedBenAmt, EedStartDate, ROW_NUMBER() OVER (PARTITION BY EedEEID, EedCOID, EedDedCode ORDER BY EedStartDate DESC) AS RN
                            FROM dbo.EmpDedFull WITH (NOLOCK)
                            /*WHERE eedDedCode IN ('UNVOL')*/) AS A
                    WHERE RN = 1 ) AS Amt
        ON amtEEID = xEEID
        AND amtCOID = xCOID
    LEFT JOIN dbo.DedCode WITH (NOLOCK)
        ON BdmDedCode = DedDedCode
    JOIN dbo.BenGrp WITH (NOLOCK)
        ON EecDedGroupCode = CbgBenGroupCode
    ;


    Delete from dbo.U_ESEQDEMRPX_drvTbl where drvPlanType in ('LS','LC') and drvDeprecid is null
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
ALTER VIEW dbo.dsi_vwESEQDEMRPX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESEQDEMRPX_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESEQDEMRPX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202011051'
       ,expStartPerControl     = '202011051'
       ,expLastEndPerControl   = '202011129'
       ,expEndPerControl       = '202011129'
WHERE expFormatCode = 'ESEQDEMRPX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESEQDEMRPX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESEQDEMRPX_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;